

import Foundation

class Fonts {
    var lang = Locale.current.language.languageCode!.identifier
    var constants = Constants()
    
    let cairo_extra_light = "Cairo-ExtraLight-BF643384ef1b106"
    let english_cairo_variable = "Cairo-VariableFont_slntwght-BF643384ef6bbca"
    
    
    let english_MEATBUSTERS = "MEATBUSTERS-Bold"
    
    let Arabic_Bold = "ArabicModern-Bold"
    let Gotham_Bold = "Gotham-Bold"  //    Eng Bold
    
    
    let arabic_gess_bold = "GESSUniqueBold-Bold"
    let arabic_gess_light = "GESSUniqueLight-Light"
    
    func getFontLight () -> String {
        
        if lang == constants.APP_IOS_LANGUAGE_AR  {
            return arabic_gess_light
        }
        return cairo_extra_light
    }  
    

    
    func getFontBold () -> String {
        
        if lang == constants.APP_IOS_LANGUAGE_AR  {
            return arabic_gess_bold
        }
        return Gotham_Bold
    }
    
    
    
    
}
