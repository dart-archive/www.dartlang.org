import 'package:polymer/builder.dart';
        
main(args) {
  build(entryPoints: ['web/a1_ep.html','web/a2/a2_ep.html'],
        options: parseOptions(args));
}
