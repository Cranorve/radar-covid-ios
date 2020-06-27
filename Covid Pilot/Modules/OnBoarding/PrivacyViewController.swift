//
//  TermsViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 21/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class PrivacyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ExpandDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var privacyPolicyHeader: UILabel!
    private var hiddenSections = Set<Int>()
    
    private var tableHeaders = [
        "1. ¿Quién es responsable del tratamiento de tus datos como usuario de “Radar COVID”?",
        "2.  ¿Qué datos tratamos sobre ti?",
        "3. ¿Cómo obtenemos y de dónde proceden tus datos?",
        "4. ¿Para qué y por qué utilizamos tus datos? ",
        "5. ¿Durante cuánto tiempo conservamos tus datos?",
        "6. ¿Quién tiene acceso a tus datos?",
        "7. ¿Cuáles son tus derechos y cómo puedes controlar tus datos?",
        "8.  ¿Cómo protegemos tus datos?",
        "9.  ¿Cuál es la legitimación para el tratamiento de tus datos?",
        "10. Transmisión y flujo de datos",
        "11. ¿Qué tienes que tener especialmente en cuenta al utilizar “Radar COVID”?",
        "12. Política de cookies"
    ]
    
   
    
    private var tableViewData: [[NSAttributedString]]!
    
    func generateTableViewData() -> [[NSAttributedString]]{
        
        
 

        let attributedStringParagraphStyle1 = NSMutableParagraphStyle()
        let attributedString1 = NSAttributedString(string: "La aplicación “Radar COVID” no requiere ni almacena datos de carácter personal.\nEn todo caso, el TITULAR de la Aplicación es la Secretaría General de Administración Digital, órgano directivo de la Secretaría de Estado de Digitalización e Inteligencia Artificial (Ministerio de Asuntos Económicos y Transformación Digital).", attributes:[NSAttributedString.Key.paragraphStyle:attributedStringParagraphStyle1,NSAttributedString.Key.font:UIFont(name:"Muli-Regular", size:20.0)!])
        


       let attributedStringParagraphStyle2 = NSMutableParagraphStyle()
       attributedStringParagraphStyle2.tailIndent = 468.0
       attributedStringParagraphStyle2.paragraphSpacingBefore = 6.0

       let attributedStringParagraphStyleOne2 = NSMutableParagraphStyle()
       attributedStringParagraphStyleOne2.alignment = NSTextAlignment.justified
       attributedStringParagraphStyleOne2.firstLineHeadIndent = 17.85
       attributedStringParagraphStyleOne2.headIndent = 35.7
       attributedStringParagraphStyleOne2.tailIndent = 468.0
       attributedStringParagraphStyleOne2.paragraphSpacingBefore = 6.0

       let attributedStringParagraphStyleTwo2 = NSMutableParagraphStyle()
       attributedStringParagraphStyleTwo2.tailIndent = 468.0
       attributedStringParagraphStyleTwo2.paragraphSpacingBefore = 6.0

       let attributedStringParagraphStyleThree2 = NSMutableParagraphStyle()
       attributedStringParagraphStyleThree2.firstLineHeadIndent = 17.85
       attributedStringParagraphStyleThree2.headIndent = 35.7
       attributedStringParagraphStyleThree2.tailIndent = 468.0
       attributedStringParagraphStyleThree2.paragraphSpacingBefore = 6.0

       let attributedString2 = NSMutableAttributedString(string: "Los datos manejados por la aplicación no permiten la identificación directa del usuario o de su dispositivo, y son solo los necesarios para el único fin de informarte de que has estado expuesto a una situación de riesgo de contagio por la COVID-19, así como para facilitar la posible adopción de medidas preventivas y asistenciales. En ningún caso se rastrearán los movimientos de los USUARIOS, excluyendo así cualquier forma de geolocalización.\nComo parte del sistema de alerta de contagios de la COVID-19, se procesarán los siguientes datos con referencia a las diferentes categorías de partes interesadas.\nLos siguientes datos se procesarán solo para los usuarios que hayan dado positivo por COVID-19 para los fines especificados a continuación:\n•\tLas claves de exposición temporal con las que el dispositivo del usuario ha generado los códigos aleatorios enviados (identificadores efímeros Bluetooth), a los dispositivos con los que el usuario ha entrado en contacto, hasta un máximo de 14 días anteriores. Estas claves no guardan relación alguna con la identidad del USUARIO, y se suben al servidor para que puedan ser descargadas por aplicaciones similares en poder de otros usuarios. Con estas claves, mediante un procesamiento que tiene lugar en el teléfono móvil de forma descentralizada, se puede advertir al USUARIO sobre el riesgo de contagio por haber estado en contacto reciente con una persona que ha sido diagnosticada por COVID-19, sin que la aplicación pueda derivar su identidad o el lugar donde tuvo lugar el contacto.\n•\tUn código de confirmación de un solo uso de 12 dígitos facilitado por las autoridades sanitarias en caso de prueba positiva por COVID-19. Este código debe ser informado por el usuario para permitir la carga voluntaria de las claves de exposición al servidor.\n•\tCuestionario voluntario para la recogida de información sobre la experiencia de uso de la aplicación, comprensión de la misma o percepción sobre la privacidad entre otros.\nToda la información se recogerá con fines estrictamente de interés público en el ámbito de la salud pública, y ante la situación de emergencia sanitaria decretada, a fin de proteger y salvaguardar un interés esencial para la vida de las personas, en los términos descritos en esta política de privacidad.\nLa legislación aplicable se enumera a continuación:\n•\tReglamento (UE) 2016/679, de 27 de abril de 2016, relativo a la protección de las personas físicas en lo que respecta al tratamiento de datos personales y a la libre circulación de estos datos y por el que se deroga la Directiva 95/46/CE (Reglamento General de Protección de Datos).\n•\tLey Orgánica 3/2018, de 5 de diciembre, de Protección de Datos Personales y garantía de los derechos digitales.\n•\tLey 14/1986, de 25 de abril, General de Sanidad\n•\tLey Orgánica 3/1986, de 14 de abril, de Medidas Especiales en Materia de Salud Pública.\n•\tLey 33/2011, de 4 de octubre, General de Salud Pública.\n•\tReal Decreto 463/2020 de 14 de marzo, por el que se declara el estado de alarma para la gestión de la situación de crisis sanitaria ocasionada por el COVID-19 que atribuye al Ministro de Sanidad la necesaria competencia en todo el territorio nacional.\n•\tOrden Ministerial SND/297/2020 de 27 de marzo, por la que se encomienda a la Secretaría de Estado de Digitalización e Inteligencia Artificial, del Ministerio de Asuntos Económicos y Transformación Digital, el desarrollo de nuevas actuaciones para la gestión de la crisis sanitaria ocasionada por el COVID-19.\n")

       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(0,749))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(749,2))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(751,788))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(1539,2))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(1541,259))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(1800,2))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(1802,172))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Bold", size:20.0)!, range:NSMakeRange(1974,305))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(2279,52))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(2331,2))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(2333,283))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(2616,2))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(2618,112))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(2730,2))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(2732,48))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(2780,2))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(2782,88))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(2870,2))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(2872,56))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(2928,2))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(2930,252))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(3182,2))
       attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(3184,309))
       attributedString2.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyle2, range:NSMakeRange(0,749))
       attributedString2.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleOne2, range:NSMakeRange(749,1225))
       attributedString2.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleTwo2, range:NSMakeRange(1974,357))
       attributedString2.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleThree2, range:NSMakeRange(2331,1162))
        
 

        let attributedStringParagraphStyle3 = NSMutableParagraphStyle()
        attributedStringParagraphStyle3.tailIndent = 468.0
        attributedStringParagraphStyle3.paragraphSpacingBefore = 6.0

        let attributedStringParagraphStyleOne3 = NSMutableParagraphStyle()
        attributedStringParagraphStyleOne3.firstLineHeadIndent = 17.85
        attributedStringParagraphStyleOne3.headIndent = 35.7
        attributedStringParagraphStyleOne3.tailIndent = 468.0
        attributedStringParagraphStyleOne3.paragraphSpacingBefore = 6.0

        let attributedStringParagraphStyleTwo3 = NSMutableParagraphStyle()
        attributedStringParagraphStyleTwo3.tailIndent = 468.0
        attributedStringParagraphStyleTwo3.paragraphSpacingBefore = 6.0

        let attributedString3 = NSMutableAttributedString(string: "Principalmente obtenemos tus datos directamente de ti: \n•\tNos los proporcionas tú directamente (p.ej. a través de formularios disponibles en la Aplicación o cuando contactas con nosotros). Recuerda que los datos que nos proporciones directamente deberán ser siempre reales, veraces y estar actualizados.\nEl código de confirmación de positivo por COVID-19 facilitado por el Servicio Público de Salud. Esto permitirá la subida al servidor del sistema de alerta de contagios las claves de exposición temporal con las que el dispositivo del usuario ha generado los códigos aleatorios enviados (identificadores efímeros Bluetooth), a los dispositivos con los que el usuario ha entrado en contacto, hasta un máximo de 14 días anteriores. Estas claves únicamente se suben al servidor con el consentimiento explícito e inequívoco del USUARIO, al haber introducido un código de confirmación de positivo por COVID-19.")

        attributedString3.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(0,56))
        attributedString3.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(56,2))
        attributedString3.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(58,849))
        attributedString3.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyle3, range:NSMakeRange(0,56))
        attributedString3.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleOne3, range:NSMakeRange(56,248))
        attributedString3.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleTwo3, range:NSMakeRange(304,603))
        
        
        
        let attributedStringParagraphStyle4 = NSMutableParagraphStyle()
        attributedStringParagraphStyle4.tailIndent = 468.0
        attributedStringParagraphStyle4.paragraphSpacingBefore = 6.0

        let attributedStringParagraphStyleOne4 = NSMutableParagraphStyle()
        attributedStringParagraphStyleOne4.firstLineHeadIndent = 17.85
        attributedStringParagraphStyleOne4.headIndent = 35.7
        attributedStringParagraphStyleOne4.tailIndent = 468.0
        attributedStringParagraphStyleOne4.paragraphSpacingBefore = 6.0

        let attributedStringParagraphStyleTwo4 = NSMutableParagraphStyle()
        attributedStringParagraphStyleTwo4.tailIndent = 468.0
        attributedStringParagraphStyleTwo4.paragraphSpacingBefore = 6.0

        let attributedStringParagraphStyleThree4 = NSMutableParagraphStyle()
        attributedStringParagraphStyleThree4.firstLineHeadIndent = 17.85
        attributedStringParagraphStyleThree4.headIndent = 35.7
        attributedStringParagraphStyleThree4.tailIndent = 468.0
        attributedStringParagraphStyleThree4.paragraphSpacingBefore = 6.0

        let attributedStringParagraphStyleFour4 = NSMutableParagraphStyle()
        attributedStringParagraphStyleFour4.tailIndent = 468.0
        attributedStringParagraphStyleFour4.paragraphSpacingBefore = 6.0

        let attributedString4 = NSMutableAttributedString(string: "La recogida, almacenamiento, modificación, estructuración y en su caso, eliminación, de los datos generados, constituirán operaciones de tratamiento llevadas a cabo por el Responsable, con la finalidad de garantizar el correcto funcionamiento de la App, mantener la relación de prestación del servicio  con el Usuario, y para la gestión, administración, información, prestación y mejora del servicio. \nEl objetivo de la Aplicación es contener la propagación del virus SARS-CoV-2, informando a la población de su exposición al mismo, permitiendo el reporte de casos positivos y la toma de precauciones en caso de recibir una alerta de exposición al virus.\nLa información y datos recogidos a través de la Aplicación serán tratados con fines estrictamente de interés público en el ámbito de la salud pública, ante la actual situación de emergencia sanitaria como consecuencia de la pandemia del COVID-19 y la necesidad de su control y propagación, así como para garantizar intereses vitales tuyos o de terceros, de conformidad con la normativa de protección de datos vigente.\nA tal efecto, utilizamos tus datos para prestarte el servicio de “Radar COVID” y para que puedas hacer uso de sus funcionalidades de acuerdo con sus condiciones de uso. De conformidad con el Reglamento General de Protección de Datos (RGPD) así como cualquier legislación nacional que resulte aplicable,  la Secretaría General de Administración Digital tratará todos los datos generados durante el uso de la App para las siguientes finalidades:\n•\tOfrecerte información sobre contactos considerados de riesgo de exposición a la COVID-19.\n•\tProporcionarte consejos prácticos y recomendaciones de acciones a seguir según se produzcan situaciones de riesgo de cara a la cuarentena o auto-cuarentena.\nEste tratamiento se llevará a cabo a través de la funcionalidad de alerta de contagios que permite identificar situaciones de riesgo por haber estado en contacto estrecho con personas que actualmente se encuentran infectadas por la COVID-19. De esta manera se te informará de las medidas que conviene adoptar después.\nAdicionalmente, conforme a lo establecido en la normativa aplicable, podremos tratar tus datos para las siguientes finalidades no directamente relacionadas con las funcionalidades de “Radar COVID”, adoptando las medidas técnicas y organizativas necesarias, en particular, para garantizar el respeto al principio de minimización de datos personales, incluyendo su anonimización:\n•\tPara finalidades estadísticas;\n•\tPara investigación biomédica, científica o histórica; y\n•\tPara archivo en interés público;\nEstas finalidades permitirán hacer tanto un análisis anonimizado descriptivo de la situación, que permita conocer qué y por qué está ocurriendo (p.ej. las dinámicas actuales de la sintomatología en la población), así como un análisis anonimizado predictivo sobre la evolución de ésta (p.ej. como podrían evolucionar dichas dinámicas en el futuro).\nAdemás, estas finalidades son especialmente relevantes, no sólo para conocer y predecir la situación de emergencia sanitaria actual, sino también para futuras investigaciones médicas, científicas e históricas que sean precisas llevar a cabo, entre otros objetivos, para prevenir y detectar situaciones similares que puedan tener lugar en el futuro.\n")

        attributedString4.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(0,1517))
        attributedString4.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(1517,2))
        attributedString4.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(1519,90))
        attributedString4.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(1609,2))
        attributedString4.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(1611,853))
        attributedString4.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(2464,2))
        attributedString4.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(2466,31))
        attributedString4.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(2497,2))
        attributedString4.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(2499,56))
        attributedString4.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(2555,2))
        attributedString4.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(2557,730))
        attributedString4.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyle4, range:NSMakeRange(0,1517))
        attributedString4.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleOne4, range:NSMakeRange(1517,251))
        attributedString4.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleTwo4, range:NSMakeRange(1768,696))
        attributedString4.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleThree4, range:NSMakeRange(2464,126))
        attributedString4.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleFour4, range:NSMakeRange(2590,697))
        attributedString4.addAttribute(NSAttributedString.Key.underlineStyle, value:1.0, range:NSMakeRange(1222,18))
        
        
        let attributedString5 = NSAttributedString(string: "Solamente conservaremos y trataremos los datos recibidos para las finalidades indicadas en el punto 4 anterior, por lo que sólo los conservaremos durante el tiempo que perdure la crisis sanitaria, con la excepción de las finalidades estadísticas, de investigación o archivo en interés público, cuyo plazo de conservación será de un máximo de dos años, todo ello de conformidad con los principios legales de tratamiento de datos, en particular el de minimización de datos.\nEn el momento en que finalice el periodo de conservación de tus datos, estos serán eliminados conforme a los requisitos establecidos en la normativa aplicable. \nLos datos se almacenarán en el dispositivo del USUARIO, y solo aquellos que hayan sido comunicados por los USUARIOS diagnosticados como positivos por COVID-19 y que sean necesarios para cumplir la finalidad de alerta de contagios se cargarán en el servidor a disposición del resto de USUARIOS de esta aplicación.\nLos claves recibidas en el servidor de alerta de contagios se suprimirán  tan pronto como dejen de ser necesarios para alertar a las personas y como máximo tras un período de un mes (período de incubación más un margen).", attributes:[NSAttributedString.Key.font:UIFont(name:"Muli-Regular", size:20.0)!])
        
        
        let attributedString6 = NSAttributedString(string: "Ni la aplicación “Radar COVID” ni el servidor de alerta de contagios almacenan datos personales de ningún tipo. Los datos gestionados por la aplicación móvil (claves diarias de exposición temporal e identificadores efímeros Bluetooth) se almacenan únicamente en el dispositivo del usuario a los efectos de poder hacer cálculos y derivar informes al USUARIO sobre su riesgo de exposición a la COVID-19.\nSolo en el caso de reportar un diagnóstico positivo por COVID-19, las últimas 14 claves diarias de exposición temporal generadas en el dispositivo, y bajo el consentimiento explícito e inequívoco del USUARIO, son subidas al servidor para su difusión al conjunto de USUARIOS de este sistema.\nEstas claves no guardan relación alguna con la identidad de los dispositivos móviles ni con datos personales de los USUARIOS de la Aplicación.", attributes:[NSAttributedString.Key.font:UIFont(name:"Muli-Regular", size:20.0)!])
        
        
       

        
        let attributedString7 = NSMutableAttributedString(string: "Dado que la aplicación Rada COVID no almacena datos personales, no son de aplicación los derechos de acceso, rectificación, supresión, limitación, oposición y portabilidad, así como a no ser objeto de decisiones basadas únicamente en el tratamiento automatizado de sus datos. \nAparte de todo lo anterior, tenemos obligación de indicarte que te asiste en todo momento el derecho para presentar una reclamación ante Agencia Española de Protección de Datos (www.aepd.es). ")

        attributedString7.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(0,469))
        attributedString7.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(red:0.017, green:0.198, blue:1.0, alpha:1.0), range:NSMakeRange(455,11))
        attributedString7.addAttribute(NSAttributedString.Key.underlineStyle, value:1.0, range:NSMakeRange(455,11))
        attributedString7.addAttribute(NSAttributedString.Key.link, value:NSURL(string:"http://www.aepd.es")!, range:NSMakeRange(455,11))
        
        

        let attributedString8 = NSAttributedString(string: "El sistema Radar COVID no almacena datos personales.\nEn todo caso, las medidas de seguridad implantadas se corresponden con las previstas en el anexo II (Medidas de seguridad) del Real Decreto 3/2010, de 8 de enero, por el que se regula el Esquema Nacional de Seguridad en el ámbito de la Administración Electrónica.\nFinalmente, te informamos que tanto el almacenamiento como el resto de las actividades del tratamiento de datos no personales utilizados estarán siempre ubicados dentro de la Unión Europea.", attributes:[NSAttributedString.Key.font:UIFont(name:"Muli-Regular", size:20.0)!])
        
   

        let attributedStringParagraphStyle9 = NSMutableParagraphStyle()
        attributedStringParagraphStyle9.tailIndent = 468.0
        attributedStringParagraphStyle9.paragraphSpacingBefore = 6.0

        let attributedStringParagraphStyleOne9 = NSMutableParagraphStyle()
        attributedStringParagraphStyleOne9.firstLineHeadIndent = 18.0
        attributedStringParagraphStyleOne9.headIndent = 36.0
        attributedStringParagraphStyleOne9.tailIndent = 468.0
        attributedStringParagraphStyleOne9.paragraphSpacingBefore = 6.0

        let attributedString9 = NSMutableAttributedString(string: "Los datos generados se tratarán legítimamente con las siguientes bases legales:\n•\tEl consentimiento del usuario libre, específico, informado e inequívoco del USUARIO, poniendo a su disposición la presente política de privacidad, que deberá aceptar mediante el marcado de la casilla dispuesta al efecto.\n•\tRazones de interés público en el ámbito de la salud pública, como la protección frente a amenazas transfronterizas graves para la salud (artículo 9.2 i) del RGPD), para el tratamiento de los datos de salud (por ejemplo, el estado de una persona contagiada o información sobre síntomas, etc.).\n•\tCumplimiento de una misión realizada en interés público o en el ejercicio de poderes públicos conferidos al responsable del tratamiento (artículo 6.1 e) RGPD).\n•\tFines de archivo den interés público, fines de investigación científica o histórica o fines estadísticos (artículo 9.2 j) RGPD).")

        attributedString9.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(0,80))
        attributedString9.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(80,2))
        attributedString9.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(82,221))
        attributedString9.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(303,2))
        attributedString9.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(305,293))
        attributedString9.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(598,2))
        attributedString9.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(600,160))
        attributedString9.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(760,2))
        attributedString9.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(762,128))
        attributedString9.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyle9, range:NSMakeRange(0,80))
        attributedString9.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleOne9, range:NSMakeRange(80,810))
        


        let attributedStringParagraphStyle10 = NSMutableParagraphStyle()
        attributedStringParagraphStyle10.tailIndent = 468.0
        attributedStringParagraphStyle10.paragraphSpacingBefore = 6.0

        let attributedStringParagraphStyleOne10 = NSMutableParagraphStyle()
        attributedStringParagraphStyleOne10.firstLineHeadIndent = 18.0
        attributedStringParagraphStyleOne10.headIndent = 36.0
        attributedStringParagraphStyleOne10.tailIndent = 468.0
        attributedStringParagraphStyleOne10.paragraphSpacingBefore = 6.0

        let attributedStringParagraphStyleTwo10 = NSMutableParagraphStyle()
        attributedStringParagraphStyleTwo10.firstLineHeadIndent = 35.4
        attributedStringParagraphStyleTwo10.headIndent = 35.4
        attributedStringParagraphStyleTwo10.tailIndent = 468.0
        attributedStringParagraphStyleTwo10.paragraphSpacingBefore = 6.0

        let attributedStringParagraphStyleThree10 = NSMutableParagraphStyle()
        attributedStringParagraphStyleThree10.firstLineHeadIndent = 18.0
        attributedStringParagraphStyleThree10.headIndent = 36.0
        attributedStringParagraphStyleThree10.tailIndent = 468.0
        attributedStringParagraphStyleThree10.paragraphSpacingBefore = 6.0

        let attributedStringParagraphStyleFour10 = NSMutableParagraphStyle()
        attributedStringParagraphStyleFour10.firstLineHeadIndent = 35.4
        attributedStringParagraphStyleFour10.headIndent = 35.4
        attributedStringParagraphStyleFour10.tailIndent = 468.0
        attributedStringParagraphStyleFour10.paragraphSpacingBefore = 6.0

        let attributedString10 = NSMutableAttributedString(string: "Para los fines descritos en el punto 4, los datos se tratan de la siguiente manera:\n•\tDatos de un usuario contagiado de COVID-19: \nCada 15-20 minutos la Aplicación genera un código aleatorio (identificador efímero Bluetooth) a partir de la clave de exposición temporal, generada de forma diaria. Estos códigos aleatorios se envían a dispositivos cercanos, accesibles a través de Bluetooth Low Energy, produciendo un intercambio de códigos aleatorios entre dispositivos.\nEn caso de que hayas sido diagnosticado de COVID-19, podrás reportar tu diagnóstico, de forma voluntaria,  a través del suministro de un código de confirmación de un solo uso facilitado por las autoridades sanitarias, que será validado en el servidor. \nSolo si el usuario confirma en la aplicación de forma expresa la intención de enviar las claves de exposición correspondientes a los últimos 14 días, éstas se enviarán al servidor de la aplicación que, después de verificar la exactitud del código, las pone a disposición de todos los dispositivos que tienen instalada la Aplicación.\n•\tDatos de las personas que han estado en contacto (epidemiológico) con la persona infectada:\nDurante su funcionamiento normal, la aplicación descarga periódicamente las claves de exposición temporal compartidas voluntariamente por los usuarios diagnosticados por COVID-19 del servidor, para compararlas con los códigos aleatorios registrados en los días anteriores como resultado de contactos con otros usuarios.\nSi se encuentra una coincidencia, la aplicación ejecuta un algoritmo en el dispositivo que, en función de la duración y la distancia estimada del contacto, y de acuerdo con los criterios establecidos por las autoridades sanitarias, decide si se muestra una notificación en el dispositivo del usuario expuesto al riesgo de contagio, advirtiéndole del contacto, comunicándole la fecha del mismo e invitándolo a auto-confinarse, y contactar con las autoridades sanitarias.\nEstas claves remitidas al servidor no permiten la identificación directa de los usuarios y son necesarias para garantizar el correcto funcionamiento del sistema de alerta de contagios.\nEl Titular de la Aplicación podrá dar acceso o transmitir los datos a terceros proveedores de servicios, con los que haya suscrito acuerdos de encargo de tratamiento de datos, y que únicamente accedan a dicha información para prestar un servicio en favor y por cuenta del Responsable.\n")

        attributedString10.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(0,84))
        attributedString10.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(84,2))
        attributedString10.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(86,970))
        attributedString10.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(1056,2))
        attributedString10.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(1058,1352))
        attributedString10.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyle10, range:NSMakeRange(0,84))
        attributedString10.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleOne10, range:NSMakeRange(84,47))
        attributedString10.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleTwo10, range:NSMakeRange(131,925))
        attributedString10.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleThree10, range:NSMakeRange(1056,94))
        attributedString10.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleFour10, range:NSMakeRange(1150,1260))
        
        
        let attributedStringParagraphStyle11 = NSMutableParagraphStyle()
        attributedStringParagraphStyle11.alignment = NSTextAlignment.justified
        attributedStringParagraphStyle11.tailIndent = 468.0
        attributedStringParagraphStyle11.paragraphSpacingBefore = 6.0

        let attributedStringParagraphStyleOne11 = NSMutableParagraphStyle()
        attributedStringParagraphStyleOne11.alignment = NSTextAlignment.justified
        attributedStringParagraphStyleOne11.firstLineHeadIndent = 17.85
        attributedStringParagraphStyleOne11.headIndent = 35.7
        attributedStringParagraphStyleOne11.tailIndent = 468.0
        attributedStringParagraphStyleOne11.paragraphSpacingBefore = 6.0

        let attributedString11 = NSMutableAttributedString(string: "Has de tener en cuenta determinados aspectos relativos a la edad mínima de utilización de Aplicación, la calidad de los datos que nos proporcionas, así como la desinstalación de la Aplicación en tu dispositivo móvil.\n•\tEdad mínima de utilización: para poder registrarte y utilizar “Radar COVID” tienes que ser mayor de 18 años o contar con la autorización de tus padres y/o tutores legales. Por tanto, al darte de alta en la Aplicación, garantizas al Titular que eres mayor de dicha edad o, en caso contrario, que cuentas con la mencionada autorización. Tenemos el derecho de verificar en cualquier momento si cumples esta condición. \n•\tCalidad de los datos que nos proporcionas: la información que nos facilites en el uso de los servicios de la Aplicación deberá de ser siempre real, veraz y estar actualizada.\n•\tDesinstalación de la Aplicación: en general, puede haber dos situaciones en las que se proceda a la desactivación técnica de la Aplicación en tu dispositivo: 1) que lo realices voluntariamente, y 2) que desde el Responsable del Tratamiento se proceda a la desactivación técnica de la Aplicación en tu dispositivo (p.ej. en casos en los que detectemos que has incumplido las condiciones de uso de la Aplicación).")

        attributedString11.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(0,217))
        attributedString11.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(217,2))
        attributedString11.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(219,416))
        attributedString11.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(635,2))
        attributedString11.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(637,175))
        attributedString11.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20.0)!, range:NSMakeRange(812,2))
        attributedString11.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(814,411))
        attributedString11.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyle11, range:NSMakeRange(0,217))
        attributedString11.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleOne11, range:NSMakeRange(217,1008))
        
        let attributedString12 = NSMutableAttributedString(string: "Utilizamos solamente cookies técnicas que permiten al usuario la navegación y la utilización de las diferentes opciones o servicios que se ofrecen en la Aplicación como, por ejemplo, acceder a partes de acceso restringido o utilizar elementos de seguridad durante la navegación.\n\nHe leído el documento POLÍTICA DE PRIVACIDAD DE LA APLICACIÓN “Radar COVID”.")
        attributedString12.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(0,356))

        
        return [
            [
               attributedString1
            ],
            [
                attributedString2
            ],
            [
                attributedString3
            ],
            [
                attributedString4
            ],
            [
                attributedString5
            ],
            [
                attributedString6
            ],
            [
                attributedString7
            ],
            [
                attributedString8
            ],
            [
                attributedString9
            ],
            [
                attributedString10
            ],
            [
                attributedString11
            ],
            [
                attributedString12
            ]
            
        ]
    }
    
    @IBAction func onClose(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewData = self.generateTableViewData()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        
       

        let attributedString = NSMutableAttributedString(string: "Por favor, lee detenidamente esta política de privacidad para usuarios de la aplicación móvil “Radar COVID” (o la “Aplicación”), donde podrás encontrar toda la información sobre los datos que utilizamos, cómo lo usamos y qué control tienes sobre los mismos.\nAVISO IMPORTANTE: El USUARIO queda apercibido de que esta aplicación forma parte de una EXPERIENCIA PILOTO LIMITADA AL ÁMBITO GEOGRÁFICO DE LA ISLA DE LA GOMERA. TODAS LAS NOTIFICACIONES SOBRE UNA POSIBLE EXPOSICIÓN A UNA PERSONA CONTAGIADA POR LA COVID-19 SON SIMULADAS. Adicionalmente, este servicio será discontinuado al término de la experiencia piloto.\nAVISO IMPORTANTE: El USUARIO queda apercibido de que la utilización de la Aplicación NO CONSTITUYE EN NINGÚN CASO UN SERVICIO DE DIAGNÓSTICO MÉDICO, DE ATENCIÓN DE URGENCIAS O DE PRESCRIPCIÓN DE TRATAMIENTOS FARMACOLÓGICOS. Se advierte y pone en conocimiento del USUARIO, que la utilización de la Aplicación no puede en ningún caso sustituir la consulta presencial personal frente a un profesional médico debidamente cualificado.")

        attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Light", size:20.0)!, range:NSMakeRange(0,258))
        attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Bold", size:20.0)!, range:NSMakeRange(258,16))
        attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Light", size:20.0)!, range:NSMakeRange(274,72))
        attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Bold", size:20.0)!, range:NSMakeRange(346,182))
        attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(528,88))
        attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Bold", size:20.0)!, range:NSMakeRange(616,16))
        attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(632,69))
        attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Bold", size:20.0)!, range:NSMakeRange(701,137))
        attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Light", size:20.0)!, range:NSMakeRange(838,86))
        attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Bold", size:20.0)!, range:NSMakeRange(924,120))
        attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Light", size:20.0)!, range:NSMakeRange(1044,1))
       
        self.privacyPolicyHeader.attributedText = attributedString
        registerTableViewCells()
        setAllSectionsHidden()
    }
    
    private func setAllSectionsHidden() {
        for i  in 1..<self.tableViewData.count {
            hiddenSections.insert(i)
        }
    }
    
    private func registerTableViewCells() {
        tableView.register(TableHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.attributedText = self.tableViewData[indexPath.section][indexPath.row]
        cell.textLabel?.numberOfLines = 0
//        cell.textLabel?.font = UIFont(name: "Muli-Light", size: 20.0)
        cell.backgroundColor = #colorLiteral(red: 0.9800000191, green: 0.976000011, blue: 0.9689999819, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
            return 0
        }
        return self.tableViewData[section].count
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TableHeaderView
        view.title = tableHeaders[section]
        view.expanded = !hiddenSections.contains(section)
        view.delegate = self
        view.section = section
        tableViewHeight.constant = calculateHeight()
        return view
    }
    
    func toggle(section: Int?) {
        if let section = section {
            if self.hiddenSections.contains(section) {
                self.hiddenSections.remove(section)
//                self.tableView.insertRows(at: indexPathsForSection(section), with: .none)
            } else {
                self.hiddenSections.insert(section)
//                self.tableView.deleteRows(at: indexPathsForSection(section), with: .none)
               
            }
        }
        tableView.reloadData()
        tableViewHeight.constant = calculateHeight()
    }
    
    private func indexPathsForSection(_ section: Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        
        for row in 0..<self.tableViewData[section].count {
            indexPaths.append(IndexPath(row: row,
                                        section: section))
        }
        
        return indexPaths
    }
    
    private func calculateHeight() -> CGFloat {
//        return 30 * CGFloat(tableHeaders.count)
       
        tableView.layoutIfNeeded()

        return tableView.contentSize.height + tableView.contentInset.bottom + tableView.contentInset.top
    }


}
