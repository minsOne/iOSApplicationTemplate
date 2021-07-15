# ResourcePackage

* Image, Color 리소스를 관리하는 라이브러리

## TODO
* Color는 UIColor(name:in:compatibleWith:)으로 관리하는 것이 좋을지, 아니면 코드 + colorLiteral를 이용하는 것이 좋을지 고민
* ref1 : https://stackoverflow.com/a/61776608/2749449
* ref2 : https://github.com/apple/swift/blob/main/test/Sema/object_literals_osx.swift

```
extension UIColor {
    static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return light }
        return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
    }
}

struct MyColors {

   ///> This is what you are getting from designers,
   /// in case they are not providing consistent color naming.
   /// Can be also just strings with HEX-codes.
   static let xF9EFB1 = #colorLiteral(red: 0.9764705882352941, green: 0.9372549019607843, blue: 0.6941176470588235, alpha: 1)
   static let x6A6A6A = #colorLiteral(red: 0.4156862745098039, green: 0.4156862745098039, blue: 0.4156862745098039, alpha: 1)
   static let xFEFEFE = #colorLiteral(red: 0.9960784313725490, green: 0.9960784313725490, blue: 0.9960784313725490, alpha: 1)
   static let x202020 = #colorLiteral(red: 0.1254901960784314, green: 0.1254901960784314, blue: 0.1254901960784314, alpha: 1)
   ///<

   static var myLabelForeground: UIColor {
      return UIColor.dynamicColor(light: MyColors.x6A6A6A, dark: MyColors.xF9EFB1)
   }

   static var myViewBackground: UIColor {
      return UIColor.dynamicColor(light: MyColors.xFEFEFE, dark: MyColors.x202020)
   }
}
```
