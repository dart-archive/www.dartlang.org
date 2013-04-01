// BEGIN(min)
/**
 * Returns the lesser of two numbers.
 *
 * Returns NaN if either argument is NaN.
 * The lesser of -0.0 and 0.0 is -0.0.
 * If the arguments are otherwise equal (including int and doubles with the
 * same mathematical value) then it is unspecified which of the two arguments
 * is returned.
 *
 *     return min(100, value);
 */
num min(num a, num b) {/*...*/}
// END(min)

// This doc doesn't seem to be generated, no matter whether
// I use a triple-/ or the other kind of doc comment.
// BEGIN(PI)
/// The PI constant.
const double PI = 3.1415926535897932;
// END(PI)

/**
 * ...
 * For example:
 *
 *     Future<int> future = getFutureFromSomewhere();
 *     future.then((value) {
 *       print("I received the number $value");
 *     });
 *
 * ...
 * 
 * ## header text until newline
 * 
 * * item continues until next list item or blank line
 * 
 * Here's a numbered list (I hope):
 * 
 *   1. numbered item continues until next list item or blank line
 *   2. next numbered item
 * 
 * Some different fonts like `code` (note the backquotes) or [:code:],
 * _italics_ or *italics*,
 * **boldface** or __boldface__.
 * Example:
 * 
 * **Warning:** This feature is not yet supported in all modern browsers.
 * See <http://caniuse.com/flexbox> for current status.
 */ 
class SomeClass {
  /// An instance variable.
  int a;
}
