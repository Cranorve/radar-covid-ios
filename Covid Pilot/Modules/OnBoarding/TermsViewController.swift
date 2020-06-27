//
//  TermsViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 21/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ExpandDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    private var hiddenSections = Set<Int>()
    
    private var tableHeaders = ["1.  Qué es Radar COVID","2.  Uso de Radar COVID", "3. Seguridad y privacidad", "4. Cambio del servicio y terminación", "5. Propiedad intelectual e industrial", "6. Responsabilidad y obligaciones", "7.  Enlaces", "8.  Hiperenlaces", "9.  Ley aplicable y fuero", "10. Información corporativa y contacto"]
    
   
    
    private var tableViewData: [[NSAttributedString]]!
    
    func generateTableViewData() -> [[NSAttributedString]]{
        
        
 

        let attributedString1 = NSMutableAttributedString(string: "Radar COVID es una aplicación que promueve la salud pública mediante un sistema de alerta de contagios por la COVID-19, poniendo a disposición de los USUARIOS (en adelante, individualmente, el “USUARIO”, y conjuntamente los “USUARIOS”), la posibilidad de navegar por la Aplicación, accediendo a los contenidos y servicios de Radar COVID, de acuerdo con las presentes CONDICIONES DE USO. Radar COVID detecta la intensidad de señales Bluetooth intercambiadas entre dispositivos que tienen esta aplicación activa, mediante el empleo de identificadores aleatorios efímeros, que no guardan relación con la identidad del teléfono móvil empleado o el USUARIO. El dispositivo de cada USUARIO descarga periódicamente las claves Bluetooth de todos los USUARIOS de la aplicación que hayan informado a través de la misma que se les ha diagnosticado COVID-19, procediendo a determinar si ha establecido contacto de riesgo con alguno de ellos, verificado por las señales Bluetooth intercambiadas, es informado de este hecho, a fin de que pueda para tomar medidas, yde este modo evitar que el virus se propague.\nAVISO IMPORTANTE: El USUARIO queda apercibido de que la utilización de la Aplicación NO CONSTITUYE EN NINGÚN CASO UN SERVICIO DE DIAGNÓSTICO MÉDICO, DE ATENCIÓN DE URGENCIAS O DE PRESCRIPCIÓN DE TRATAMIENTOS FARMACOLÓGICOS. Se advierte y pone en conocimiento del USUARIO, que la utilización de la Aplicación no puede en ningún caso sustituir la consulta presencial personal frente a un profesional médico debidamente cualificado. Esta aplicación alerta únicamente del riesgo de un posible contagio.\n")

        attributedString1.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20)!, range:NSMakeRange(0,1097))
        attributedString1.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Bold", size:20)!, range:NSMakeRange(1097,16))
        attributedString1.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20)!, range:NSMakeRange(1113,69))
        attributedString1.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Bold", size:20)!, range:NSMakeRange(1182,137))
        attributedString1.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20)!, range:NSMakeRange(1319,86))
        attributedString1.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Bold", size:20)!, range:NSMakeRange(1405,189))
        attributedString1.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20)!, range:NSMakeRange(1594,2))
        


        let attributedString2 = NSMutableAttributedString(string: "Para la utilización de los servicios de Radar COVID, es requisito necesario que el USUARIO autorice la activación del sistema de comunicaciones Bluetooth de baja energía por parte de la Aplicación, tras la descarga de la misma.\nEl USUARIO acepta sin reserva el contenido de las presentes CONDICIONES DE USO. En consecuencia, el USUARIO deberá leer detenidamente las mismas antes del acceso y de la utilización de cualquier servicio de Radar COVID bajo su entera responsabilidad.\nAVISO IMPORTANTE: La utilización de la Aplicación es gratuita, libre y voluntaria para todos los ciudadanos. Para utilizar Radar COVID no es necesario estar registrado, ni aportar ningún dato personal, identificativo o no identificativo. Al activar la aplicación, el USUARIO acepta: a) el envío de señales Bluetooth emitidas de forma anónima por su dispositivo; b) la recepción y almacenamiento de señales Bluetooth de aplicaciones compatibles con Radar COVID, que se mantienen de forma anónima y descentralizada en los dispositivos de los USUARIOS durante un periodo no superior a 14 días; y c) la información ofrecida al USUARIO sobre el posible riesgo de contagio, sin que en ningún momento se refieran datos personales de ningún tipo.\nEl USUARIO tiene el derecho de informar los resultados de sus pruebas de COVID-19 voluntariamente mediante el código de confirmación de un solo uso facilitado por parte de las autoridades sanitarias. La validez de este código será cotejada por las autoridades sanitarias para asegurar el correcto funcionamiento de Radar COVID. El USUARIO informará de los resultados de sus pruebas y se le solicitará el consentimiento expreso e inequívoco para compartir las claves generadas diariamente en su dispositivo, y correspondientes a los últimos 14 días. Estas claves son comunicadas a un servidor que las pondrá a disposición del conjunto de aplicaciones Radar COVID para su descarga. Las claves comunicadas no guardan relación alguna con la identificación del dispositivo o el USUARIO.\nNo se producirá ninguna discriminación a los potenciales pacientes que requieran servicios sanitarios y no hayan utilizado la aplicación.")

        attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20)!, range:NSMakeRange(0,479))
        attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Bold", size:20)!, range:NSMakeRange(479,16))
        attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20)!, range:NSMakeRange(495,93))
        attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Bold", size:20)!, range:NSMakeRange(588,127))
        attributedString2.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20)!, range:NSMakeRange(715,1422))
        
 

        let attributedString3 = NSMutableAttributedString(string: "Las medidas de seguridad implantadas se corresponden con las previstas en el anexo II (Medidas de seguridad) del Real Decreto 3/2010, de 8 de enero, por el que se regula el Esquema Nacional de Seguridad en el ámbito de la Administración Electrónica.\nTe informamos que tus datos personales serán tratados conforme a lo establecido en la Política de Privacidad de la Aplicación, cuyo contenido íntegro se puede consultar en el siguiente enlace: Política de Privacidad.\nToda la información se tratará con fines estrictamente de interés público en el ámbito de la salud pública, y ante la situación de emergencia sanitaria decretada, a fin de proteger y salvaguardar un interés esencial para la vida de las personas, en los términos descritos en la política de privacidad.\nLa información de la actividad de los USUARIOS es anónima y en ningún momento se exigirá a los USUARIOS ningún dato personal. En todo momento, el USUARIO puede desactivar el sistema de traza de contactos Bluetooth en la aplicación, así como desinstalar la misma.")

        attributedString3.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20)!, range:NSMakeRange(0,336))
        attributedString3.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Bold", size:20)!, range:NSMakeRange(336,39))
        attributedString3.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20)!, range:NSMakeRange(375,656))
        attributedString3.addAttribute(NSAttributedString.Key.underlineStyle, value:1.0, range:NSMakeRange(443,22))
        
        let attributedStringParagraphStyle = NSMutableParagraphStyle()
        let attributedString4 = NSAttributedString(string: "Radar COVID siempre está tratando de mejorar el servicio y busca ofrecer funcionalidades adicionales útiles para el USUARIO teniendo siempre presente la preservación de la salud pública. Esto significa que podemos añadir nuevas funciones o mejoras, así como eliminar algunas de las funciones. Si estas acciones afectan materialmente a los derechos y obligaciones del USUARIO, será informado a través de la Aplicación.\nEl USUARIO puede dejar de utilizar la aplicación en cualquier momento y por cualquier motivo, desinstalándola de su dispositivo.", attributes:[NSAttributedString.Key.paragraphStyle:attributedStringParagraphStyle,NSAttributedString.Key.font:UIFont(name:"Muli-Regular", size:20.0)!])
        
        
        let attributedStringParagraphStyle5 = NSMutableParagraphStyle()
        let attributedString5 = NSAttributedString(string: "La Secretaría General de Administración Digital (SGAD), dependiente de la Secretaría de Estado de Digitalización e Inteligencia Artificial del Ministerio de Asuntos Económicos y Transformación Digital, es la propietaria y TITULAR de todos los derechos de propiedad industrial e intelectual relativos a la Aplicación Radar COVID para dispositivos móviles en todo el territorio nacional. \nLos textos, diseños, imágenes, bases de datos, logos, estructura, marcas y demás elementos de Radar COVID están protegidos por las leyes y los tratados internacionales sobre propiedad intelectual e industrial. Cualquier reproducción, transmisión, adaptación, traducción, modificación, comunicación al público, o cualquier otra explotación de todo o parte del contenido de este sitio, efectuada de cualquier forma o por cualquier medio, electrónico, mecánico u otro, están estrictamente prohibidos salvo autorización previa por escrito de su correspondiente TITULAR. Cualquier infracción de estos derechos puede dar lugar a procedimientos extrajudiciales o judiciales civiles o penales que correspondan.\nEn este sentido, se otorga al USUARIO únicamente una licencia limitada, temporal, no exclusiva y revocable para que pueda utilizar, descargar y/o instalar Radar COVID en sus dispositivos, conforme a lo previsto en estas condiciones y para los usos previstos. En todo caso, el TITULAR se reserva los derechos no expresamente otorgados al USUARIO en virtud de las presentes condiciones.\nLa legitimidad de los derechos de propiedad intelectual o industrial correspondientes a los contenidos aportados por terceros es de la exclusiva responsabilidad de los mismos.\nA los efectos de preservar los posibles derechos de propiedad intelectual, en el caso de que cualquier USUARIO o un tercero considere que se ha producido una violación de sus legítimos derechos por la introducción de un determinado contenido en el Radar COVID, deberá notificar dicha circunstancia, por escrito, al TITULAR.", attributes:[NSAttributedString.Key.paragraphStyle:attributedStringParagraphStyle5,NSAttributedString.Key.font:UIFont(name:"Muli-Regular", size:20.0)!])
        
        
        let attributedStringParagraphStyle6 = NSMutableParagraphStyle()
        attributedStringParagraphStyle6.alignment = NSTextAlignment.justified
        attributedStringParagraphStyle6.tailIndent = 468.0
        attributedStringParagraphStyle6.paragraphSpacingBefore = 6.0

        let attributedStringParagraphStyleOne6 = NSMutableParagraphStyle()
        attributedStringParagraphStyleOne6.alignment = NSTextAlignment.justified
        attributedStringParagraphStyleOne6.firstLineHeadIndent = 18.0
        attributedStringParagraphStyleOne6.headIndent = 36.0
        attributedStringParagraphStyleOne6.tailIndent = 468.0
        attributedStringParagraphStyleOne6.paragraphSpacingBefore = 6.0

        let attributedStringParagraphStyleTwo6 = NSMutableParagraphStyle()
        attributedStringParagraphStyleTwo6.alignment = NSTextAlignment.justified
        attributedStringParagraphStyleTwo6.tailIndent = 468.0
        attributedStringParagraphStyleTwo6.paragraphSpacingBefore = 6.0

        let attributedStringParagraphStyleThree6 = NSMutableParagraphStyle()
        attributedStringParagraphStyleThree6.alignment = NSTextAlignment.justified
        attributedStringParagraphStyleThree6.firstLineHeadIndent = 18.0
        attributedStringParagraphStyleThree6.headIndent = 36.0
        attributedStringParagraphStyleThree6.tailIndent = 468.0
        attributedStringParagraphStyleThree6.paragraphSpacingBefore = 6.0

        let attributedStringParagraphStyleFour6 = NSMutableParagraphStyle()
        attributedStringParagraphStyleFour6.alignment = NSTextAlignment.justified
        attributedStringParagraphStyleFour6.firstLineHeadIndent = 54.0
        attributedStringParagraphStyleFour6.headIndent = 72.0
        attributedStringParagraphStyleFour6.tailIndent = 468.0
        attributedStringParagraphStyleFour6.paragraphSpacingBefore = 6.0

        let attributedStringParagraphStyleFive6 = NSMutableParagraphStyle()
        attributedStringParagraphStyleFive6.alignment = NSTextAlignment.justified
        attributedStringParagraphStyleFive6.tailIndent = 468.0
        attributedStringParagraphStyleFive6.paragraphSpacingBefore = 6.0

        let attributedString6 = NSMutableAttributedString(string: "Radar COVID se ofrece dedicando los mejores esfuerzos, dado que su calidad y disponibilidad pueden verse afectadas por múltiples factores ajenos al TITULAR como son, entre otros, el volumen de USUARIOS en la ubicación geográfica del USUARIO, limitaciones o restricciones de las redes de terceros operadores o la compatibilidad del dispositivo y sistema operativo utilizado por el USUARIO. Igualmente, los USUARIOS aceptan que el servicio pueda verse interrumpido cuando sea necesario por labores de mantenimiento.\nPor todo ello, el TITULAR no será responsable de los problemas de acceso o disponibilidad de Radar COVID y/o sus servicios, ni de los perjuicios que se pudieran causar por ello, cuando éstos procedan de factores ajenos a su ámbito de control. Igualmente, el TITULAR no se hace responsable de los siguientes hechos, ni de fallos, incompatibilidades y/o daños de tus terminales o dispositivos que, en su caso, se pudiesen derivar de la descarga y/o uso de la Aplicación:\n•\tActualización, exactitud, exhaustividad, pertinencia, actualidad y fiabilidad de sus contenidos, cualquiera que sea la causa y las dificultades o problemas técnicos o de otra naturaleza en los que tengan su origen dichos hechos.\n•\tLa calidad, titularidad, legitimidad, adecuación o pertinencia de los materiales, y demás contenidos.\nComo USUARIO de la Aplicación te obligas a:\n•\tImpedir el acceso de terceras personas no autorizadas a su aplicación.\n•\tNotificar al TITULAR con carácter inmediato cualquier indicio de la existencia de una violación en la seguridad en la Aplicación, de usos inapropiados o prohibidos de los servicios prestados desde la misma, o de fallos de seguridad de cualquier índole.\n•\tHacer buen uso de los contenidos, información y servicios prestados desde o a través de la Aplicación, conforme a la ley, la buena fe y a las buenas costumbres generalmente aceptadas, comprometiéndose expresamente a:\no\tAbstenerse de realizar prácticas o usos de los servicios con fines ilícitos, fraudulentos, lesivos de derechos o intereses del TITULAR o de terceros, infractores de las normas contenidas en el presente documento.\no\tAbstenerse de realizar cualquier tipo de acción que pudiera inutilizar, sobrecargar o dañar sistemas, equipos o servicios de la Aplicación o accesibles directa o indirectamente a través de esta.\no\tRespetar los derechos de propiedad intelectual e industrial del TITULAR y de terceros sobre los contenidos, información y servicios prestados desde o a través de la Aplicación, absteniéndose con carácter general de copiar, distribuir, reproducir o comunicar en forma alguna los mismos a terceros, de no mediar autorización expresa y por escrito del TITULAR o de los titulares de dichos derechos.\no\tNo proporcionar información falsa en la Aplicación, siendo el único responsable de la comunicación real y veraz.\no\tNo suplantar la personalidad de un tercero.\nEl USUARIO de la Aplicación es el único responsable del uso que decida realizar de los servicios de Radar COVID. El incumplimiento de las obligaciones como USUARIO podrá implicar la baja inmediata de la Aplicación y/o sus servicios; todo ello sin derecho a recibir compensación de ningún tipo, y sin perjuicio de las correspondientes acciones legales a que por parte del TITULAR hubiere lugar.\nEl TITULAR no será responsable en ningún caso de la utilización indebida de Radar COVID y de sus contenidos, siendo el USUARIO el único responsable por los daños y perjuicios que pudieran derivarse de un mal uso de estos o de la infracción de lo dispuesto en las presentes condiciones en que pueda incurrir. El USUARIO se compromete a mantener indemne al TITULAR frente a las reclamaciones o sanciones que pudiera recibir de terceros, ya sean particulares o entidades públicas o privadas, por razón de dichas infracciones, así como frente a los daños y perjuicios de todo tipo que pueda sufrir como consecuencia de las mismas.\nEn cualquier caso, el TITULAR se reserva el derecho de, en cualquier momento y sin necesidad de previo aviso, modificar o eliminar el contenido, estructura, diseño, servicios y condiciones de acceso y/o uso de esta Aplicación, siempre que lo estime oportuno, siempre que dicho cambio no afecte a los principios y derechos de protección de datos, así como el derecho interpretar las presentes condiciones, en cuantas cuestiones pudiera plantear su aplicación.\nAsimismo, queda prohibida la reproducción, distribución, transmisión, adaptación o modificación, por cualquier medio y en cualquier forma, de los contenidos de Radar COVID o sus cursos (textos, diseños, gráficos, informaciones, bases de datos, archivos de sonido y/o imagen, logos y demás elementos de estos sitios), salvo autorización previa de sus legítimos titulares.\nLa enumeración anterior tiene mero carácter enunciativo y no es, en ningún caso, exclusivo ni excluyente en ninguno de sus puntos. En todos los supuestos, El TITULAR EXCLUYE CUALQUIER RESPONSABILIDAD POR LOS DAÑOS Y PERJUICIOS DE CUALQUIER NATURALEZA DERIVADOS DIRECTA O INDIRECTAMENTE DE LOS MISMOS Y DE CUALESQUIERA OTROS NO ESPECIFICADOS DE ANÁLOGAS CARACTERISTICAS.\nEl TITUTAR NO OFRECE NINGUNA GARANTÍA, EXPRESA, IMPLÍCITA, LEGAL O VOLUNTARIA. \nEL TITULAR EXCLUYE EXPRESAMENTE TODAS LAS GARANTÍAS IMPLÍCITAS, INCLUYENDO, A TÍTULO ENUNCIATIVO, PERO NO LIMITATIVO, CUALQUIER GARANTÍA IMPLÍCITA O SANEAMIENTO DE VICIOS OCULTOS, COMERCIABILIDAD, CALIDAD SATISFACTORIA, TÍTULO, IDONEIDAD DEL PRODUCTO PARA UN PROPÓSITO EN PARTICULAR Y CUALQUIER GARANTÍA O CONDICIÓN DE NO INFRACCIÓN. ESTA EXCLUSIÓN DE RESPONSABILIDAD SÓLO SE APLICARÁ EN LA MEDIDA PERMITIDA POR LA LEY IMPERATIVA APLICABLE.\n")

        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20)!, range:NSMakeRange(0,983))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20)!, range:NSMakeRange(983,2))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20)!, range:NSMakeRange(985,229))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20)!, range:NSMakeRange(1214,2))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20)!, range:NSMakeRange(1216,146))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20)!, range:NSMakeRange(1362,2))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20)!, range:NSMakeRange(1364,71))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20)!, range:NSMakeRange(1435,2))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20)!, range:NSMakeRange(1437,253))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Symbol", size:20)!, range:NSMakeRange(1690,2))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(1692,217))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Courier", size:20.0)!, range:NSMakeRange(1909,2))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(1911,213))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Courier", size:20.0)!, range:NSMakeRange(2124,2))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(2126,195))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Courier", size:20.0)!, range:NSMakeRange(2321,2))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(2323,396))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Courier", size:20.0)!, range:NSMakeRange(2719,2))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(2721,113))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Courier", size:20.0)!, range:NSMakeRange(2834,2))
        attributedString6.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(2836,2786))
        attributedString6.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyle, range:NSMakeRange(0,983))
        attributedString6.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleOne6, range:NSMakeRange(983,335))
        attributedString6.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleTwo6, range:NSMakeRange(1318,44))
        attributedString6.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleThree6, range:NSMakeRange(1362,547))
        attributedString6.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleFour6, range:NSMakeRange(1909,971))
        attributedString6.addAttribute(NSAttributedString.Key.paragraphStyle, value:attributedStringParagraphStyleFive6, range:NSMakeRange(2880,2742))
        
        
       

        let attributedString7 = NSMutableAttributedString(string: "Radar COVID puede incluir dentro de sus contenidos enlaces con sitios pertenecientes y/o gestionados por terceros con el objeto de facilitar el acceso a información y servicios disponibles a través de Internet.\nEl TITULAR no asume ninguna responsabilidad derivada de la existencia de enlaces entre los contenidos de Radar COVID y contenidos situados fuera de los mismos o de cualquier otra mención de contenidos externos a este sitio, exceptuando aquellas responsabilidades establecidas en la normativa de protección de datos. Tales enlaces o menciones tienen una finalidad exclusivamente informativa y, en ningún caso, implican el apoyo, aprobación, comercialización o relación alguna entre el TITULAR y las personas o entidades autoras y/o gestoras de tales contenidos o titulares de los sitios donde se encuentren, ni garantía alguna del TITULAR por el correcto funcionamiento de los sitios o contenidos enlazados.")
        attributedString7.addAttribute(NSAttributedString.Key.font, value:UIFont(name:"Muli-Regular", size:20.0)!, range:NSMakeRange(0,917))
        
        

        let attributedString8 = NSAttributedString(string: "No se admite la reproducción de páginas de Radar COVID mediante hiperenlace desde otra Aplicación móvil o página web, permitiéndose exclusivamente el acceso desde la Aplicación.\nEn ningún caso se podrá dar a entender que el TITULAR autoriza el hiperenlace o que ha supervisado o asumido de cualquier forma los servicios o contenidos ofrecidos por la web desde la que se produce el hiperenlace.\nNo se podrán realizar manifestaciones o referencias falsas, incorrectas o inexactas sobre las páginas y servicios del TITULAR.\nSe prohíbe explícitamente la creación de cualquier tipo de navegador, programa, “browser” o “border environment” sobre las páginas de Radar COVID.\nNo se podrán incluir contenidos contrarios a los derechos de terceros, ni contrarios a la moral y las buenas costumbres aceptadas, ni contenidos o informaciones ilícitas, en la página web desde la que se establezca el hiperenlace.\nLa existencia de un hiperenlace entre una página web y el Radar COVID no implica la existencia de relaciones entre el TITULAR y el propietario de esa página, ni la aceptación y aprobación de sus contenidos y servicios.", attributes:[NSAttributedString.Key.paragraphStyle:attributedStringParagraphStyle,NSAttributedString.Key.font:UIFont(name:"Muli-Regular", size:20.0)!])
        
   

        let attributedString9 = NSAttributedString(string: "Las presentes condiciones de uso se regirán e interpretarán en todos y cada uno de sus extremos por la Ley Española. En aquellos casos en los que la normativa vigente no prevea la obligación de someterse a un fuero o legislación determinado, el TITULAR y los USUARIOS, con renuncia a cualquier otro fuero que pudiera corresponderles, se someten a los juzgados y tribunales de Madrid capital (España).", attributes:[NSAttributedString.Key.paragraphStyle:attributedStringParagraphStyle,NSAttributedString.Key.font:UIFont(name:"Muli-Regular", size:20.0)!])
        


        let attributedString10 = NSAttributedString(string: "Dirección: Calle de Manuel Cortina, 2, 28010 Madrid\nEl soporte al USUARIO en caso de incidencias y/o reclamaciones será principalmente online y atendido a la mayor brevedad: contacto@covid19.gob.es", attributes:[NSAttributedString.Key.paragraphStyle:attributedStringParagraphStyle,NSAttributedString.Key.font:UIFont(name:"Muli-Regular", size:20.0)!])
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
