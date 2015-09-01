---
layout: default
title: "TLS/SSL with Dart"
description: "How to configure and use TLS/SSL with Dart, client and server."
---

{% include toc.html %}

# {{ page.title }}

The Dart VM supports TLS/SSL out of the box. You can use Dart to connect to
HTTPS resources, as well as create HTTPS servers.

<aside class="alert alert-info" markdown="1">
**Version note:**
Before 1.13 is stable, the BoringSSL implementation will be available
only on the
[dev channel](/downloads/archive/).
</aside>

Starting with version 1.13, Dart uses BoringSSL, instead of openssl, as its
secure networking library. The Chrome browser, and Chromium, have already moved
to BoringSSL, and Dart is following their lead.

The BoringSSL library is a fork of OpenSSL, and is created and maintained by
Google. It is smaller and more aggressively updated and maintained.  The
management of certificates and keys, using PEM files, is easier to understand
than the security database used by NSS. Information about this new open-source
fork is at [chromium.org](boringssl).

## Examples

Below are examples of serving HTTPS and connecting to an HTTPS server with Dart.

### Creating an HTTPS server

To create an HTTPS server with server certificate `my_cert` and key `my_key`, you
must create a PEM file containing the certificate chain from `my_cert` up to the
root authority.

Concatenate the PEM certificates, which must each be a block of base64-encoded
data surrounded by `-----BEGIN CERTIFICATE-----` and
`-----END CERTIFICATE-----`,
into a single file. You can do this by copying them into a single text file in a
text editor, or by using the 'cat' command. The certificates must be in order:
the first one must be my_cert, and the final one must be the root authority.

The private key must be an encrypted PEM file, so it must be a block of data
surrounded by `-----BEGIN ENCRYPTED PRIVATE KEY-----` and `-----END ENCRYPTED
PRIVATE KEY-----`.

{% prettify dart %}
SecurityContext serverContext = new SecurityContext()
  ..useCertificateChain('path/to/my_cert.pem')
  ..usePrivateKey('path/to/my_key.pem'),
                  password: 'my_key_password');

var server = await HttpServer.bindSecure('example.com',
                              portNumber, // usually, 443
                              serverContext,
                              backlog: 5);
{% endprettify %}

### Connecting to an HTTPS resource

Code using HttpClient or SecureSocket.connect does not need to be changed,
unless it is using additional trusted CAs, such as a self-signed custom
authority used for testing.  Any calls to SecureSocket.initialize can be
removed, as this function now does nothing at all.

#### Trusting additional CAs

If you have additional custom certificate authorities, such as a self-signed
test authority you are using during development, you can set client connections
to trust a certificate chain signed by that authority by adding it to the
SecurityContext:

{% prettify dart %}
SecurityContext clientContext = new SecurityContext()
    ..setTrustedCertificates(file: 'myTrustedCAs.pem');
var client = new HttpClient(context: clientContext);
var request = await client.getUrl(
    Uri.parse("https://example.com/"));
var response = await request.close();
{% endprettify %}

The argument to SecurityContext.setTrustedCertificates can be a file containing
one or more root authority certificates, in PEM format, or a directory
containing many separate certificate files.  If a directory name is given, as
the optional argument 'directory', then additional symbolic links must be set up
in that directory using the c_rehash openssl command line utility.  These links
speed up searches in the directory.

### Exporting certificates from an NSS certificate database to PEM format

If you have an existing Dart application using dart:io and SecureSocket, with
certificates and keys in an NSS database in directory database_dir, you can
export them to PEM files using NSS and openssl command-line utilities.  The
openssl utilities are found in the openssl package on Linux distributions, and
as downloadable binaries from various internet sources on Windows.

The certutil command will export a PEM certificate to stdout, so it can be
redirected to a file. If the certificate has nickname certificate_nickname in a
database in directory database_dir,

The following example exports a new_certificate.pem.

`certutil -L -d sql:database_dir -n certificate_nickname -a > new_certificate.pem`

Exporting a private key takes two steps.  Each step produces an encrypted
file, so it asks you for the password for the old file, and the password for
the new file:

`pk12util -d sql:database_dir -o my_key.p12 -n "Full key name in database"`

`openssl pkcs12 -nocerts -in my_key.p12 -out my_key.pem`

The full name of the key in the NSS database can be shown with:

`certutil -K -d sql:database_dir`

To check your certificates, the information inside a X509 certificate can
be displayed by:

`openssl x509 -text -in certificates/trusted_certs.pem`

## Changes from 1.12 to 1.13

<aside>
The changes in 1.13 only affects network code within dart:io. Code that
uses the standalone Dart executable and secure network connections, such as
HTTPS servers, will need to be changed.
</aside>

Dart SDK 1.13 includes some breaking changes to the SecureSocket class and
related classes.  Dart programs that only use HttpClient to fetch resources from
https:// URLs should not need any changes, but Dart programs that create secure
servers need to provide their server certificate chain and private key in a
different way.  Certificates are stored in individual PEM files, rather than in
a certificate database.  This is an easier way for users to maintain their
certificates and private keys, compatible with the command-line tools provided
with OpenSSL.

The properties of a secure connection are set using the new SecurityContext
object.  All bind and connect operations on SecureSocket and SecureServerSocket
now accept a context argument of this type, which controls the certificates and
keys that are used and accepted. Secure servers must have their certificate
chain and their private key set on their security context, and clients making a
secure connection can specify which certificate authorities they trust to
authenticate their connections. A single SecurityContext object can be used for
many server sockets and client connections.

There is a default SecurityContext object, which includes trusted root
authorities for the major certificate signing authorities (CAs) that are trusted
by Mozilla's Firefox browser.  This is used if the optional context argument for
client connections and HttpClient is omitted, so using HttpClient as before this
breaking change, with no extra security setup or initialization, should continue
working as it did before.

### How pre-1.13 code needs to change

* Any code that creates secure servers must be changed, to set the server
private key and certificate chain differently.
* Adding custom trusted root certificates,
for client connections, must be done differently.

As of 1.13, requesting and checking client
certificates is currently being implemented, so the changed API is not final.

## Learning more

We're always interested in hearing your feedback. If you have questions about
how to use Dart VM with TLS/SSL, we recommend asking on
[Stack Overflow with the tag dart][so]. You can also file issues in our
[GitHub repository][issues].

[so]: http://stackoverflow.com/tags/dart
[issues]: https://github.com/dart-lang/sdk/issues
[boringssl]:  https://www.chromium.org/Home/chromium-security/boringssl
