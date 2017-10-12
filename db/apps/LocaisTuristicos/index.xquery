xquery version "3.0";

import module namespace http = "http://exist-db.org/xquery/httpclient";
import module namespace util = "http://exist-db.org/xquery/util";
import module namespace menu = 'http://www.example.com/menu' at './templates/partials/menu.xquery';

declare namespace session = "http://exist-db.org/xquery/session";
declare namespace formulario = "http://mysampleapp.local.estgf.ipp.pt";
declare namespace common = "http://mysampleapp.comum.estgf.ipp.pt";


declare variable $cores := ('blue', 'brown', '0xFFFF00', 'green', 'purple', 'yellow', 'gray', 'orange', 'red', 'white');
declare variable $coresRGB := ('#99b3ff', '#997300', '#ffff00', '#99e600', '#e699ff', '#ffd633', '#d9d9d9', '#ffaf1a', '#ff6666', 'white');

declare variable $alfanumerico := ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');


declare function local:join-string($numbers, $int)
{
    if ($int <= count($numbers)) then
        concat("&amp;", $numbers[$int]/marker, local:join-string($numbers, $int + 1))
    else
        ()
};


declare function local:constrution-button($numbers, $int)
{
    if ($int <= count($numbers)) then
        
        <li
            style="display:inline">
            <a
                class="btn btn-lg"
                href="templates/Publico/detalhes.xquery?id={$numbers[$int]/id}"
                style="background-color:{$numbers[$int]/color}">{$numbers[$int]/label}
            
            </a>
            {local:constrution-button($numbers, $int + 1)}
        </li>
    else
        ()


};

declare function local:get-Label($count)
{
    (:floor arredonda o numero por defeito:)
    (:36 é o maximo de posiçoes de caracteres alfa-numericos:)
    (:dividimos para conseguir identificar a proproçao direta entre o contador e o numero maximo:)
    (:para depois acharmos a posiçao entre [0-36]:)
    (:ex.: 80/36 =2.22 - floor(2.22)= 0.22 * 36 = 7.92:)
    (: round(7.92) = 8 significa que vamos pegar na posiçao 8:)
    let $tmp := $count div 36 - floor($count div 36)
    
    (: o count do cliclo for começa a 1, devido a isso é necessario retirar o +1 
      da conta para nao perdermos a primeira posiçao do array:)
    return
        if ($count < 36) then
            round($tmp * 36)
        else
            round($tmp * 36) + 1


};

declare function local:get-Color($count)
{
    (:floor arredonda o numero por defeito:)
    (:36 é o maximo de posiçoes de caracteres alfa-numericos:)
    (:dividimos para conseguir identificar a proporçao direta entre o contador e o numero maximo:)
    (:para depois acharmos a posiçao entre [0-36]:)
    (:ex.: floor(2.22)= 2:)
    floor($count div 36) + 1
};

declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

declare function local:initPage() {
    let $new_map := "https://maps.googleapis.com/maps/api/staticmap?autoscale=1&amp;size=600x600&amp;maptype=hybrid"
    
    let $odk-server := "https://pei-trabalho.appspot.com"
    
    let $amp := "&amp;"
    let $map := "https://maps.googleapis.com/maps/api/staticmap?autoscale=1&amp;size=400x400&amp;maptype=roadmap&amp;visual_refresh=true"
    let $gmap-api-key := 'AIzaSyDjL0B5IDSL8Rc-pZ00-rML06CEMAzfedg'
    let $dataSelection := for $data in doc("/db/apps/LocaisTuristicos/data/Locais/lista-de-locaisValidos.xml")//formulario:local
                                let $id := $data/formulario:id                                
                                let $latitude := $data/formulario:latitude
                                let $longitude := $data/formulario:longitude
                                return
                                    <formulario>
                                        <id>{$id}</id>
                                        <latitude>{$latitude}</latitude>
                                        <longitude>{$longitude}</longitude>
                                    </formulario>
    
    let $marker := for $data at $count in $dataSelection
                        
                        let $label := local:get-Label($count)
                        let $color := local:get-Color($count)
                        let $latitude := $data/latitude
                        let $longitude := $data/longitude
                        let $map := concat("markers=color:", $cores[$color], "%7Clabel:", $alfanumerico[$label], "%7C", $latitude, ",", $longitude)                      
                        return
                            <object>
                                <id>{$data/id}</id>
                                <marker>{$map}</marker>
                                <label>{$alfanumerico[$label]}</label>
                                <color>{$coresRGB[$color]}</color>
                            </object>
    
    
    return
        <html
            xmlns="http://www.w3.org/1999/xhtml"
            xmlns:ev="http://www.w3.org/2001/xml-events"
            xmlns:common="http://mysampleapp.comum.estgf.ipp.pt"
            xmlns:funcionario="http://mysampleapp.funcionario.estgf.ipp.pt"
            xmlns:xs="http://www.w3.org/2001/XMLSchema"
            xmlns:xf="http://www.w3.org/2002/xforms"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            lang="pt">
            
            <head>
                
                <meta
                    charset="utf-8"/>
                <meta
                    name="viewport"
                    content="width=device-width, initial-scale=1"/>
                <meta
                    name="description"
                    content=""/>
                <meta
                    name="author"
                    content=""/>
                
                <title>Locais Turísticos - Felgueiras</title>
                
                <link
                    rel="stylesheet"
                    type="text/css"
                    href="resources/css/bootstrap.min.css"/>
                <link
                    rel="stylesheet"
                    type="text/css"
                    href="resources/css/geral.css"/>
                <!-- Custom CSS -->
                <link
                    href="resources/css/scrolling-nav.css"
                    rel="stylesheet"/>
                <link
                    href="resources/css/detalhes.css"
                    rel="stylesheet"/>
            
            
            
            </head>
            
          
            <body
                id="page-top"
                data-spy="scroll"
                data-target=".navbar-fixed-top">
                <!-- Navigation -->
                {
                let $nav := if(session:get-attribute("user"))then
                                    let $typeUser := session:get-attribute("userType")
                                    let $user := session:get-attribute("user")
                                    let $nav_session :=  if($typeUser = "admin")then
                                          menu:top-menu-admin($user,"http://localhost:8887/exist/apps/LocaisTuristicos/templates/Privado/mapa.xquery","./resources")
                                      else(
                                          menu:top-menu-funcionario($user,"http://localhost:8887/exist/apps/LocaisTuristicos/templates/Privado/mapa.xquery","./resources")
                                      )
                                      return $nav_session
                             else(
                                 menu:top-menu-publico("")
                             
                             )
                
                return $nav
                }
                
                
                <!-- Intro Section -->
                <section
                    id="intro"
                    class="intro-section">
                    <div
                        class="container">
                        <div
                            class="row">
                            <div
                                class="col-lg-6 col-sm-8 col-md-6 col-xs-8 well well-transparent">
                                <div
                                    class="well-title">
                                    <h1>Locais Turísticos em Felgueiras </h1>
                                </div>
                                <p>Permita ajudar-vos a visitar os locais com maior interesse na cidade de
                                    Felgueiras para assim conseguir desfrutar os melhores espaços ou vistas
                                    da cidade</p>
                                <br/>
                                <div
                                    class=" text-center">
                                    <a
                                        id="btn-bootstrap"
                                        class="btn btn-primary btn-md  page-scroll"
                                        href="#about">Locais Turísticos</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- About Section -->
                <section
                    id="about"
                    class="about-section">
                    <div
                        class="container">
                        <div
                            class="row">
                            <div
                                class="col-lg-12 col-sm-12 col-xs-12 col-md-12 ">
                                <div
                                    class="well-title">
                                    <h1>Locais Turísticos</h1>
                                </div>
                                <div
                                    class="media">
                                    <div
                                        class="media-left media-middle">
                                        <img
                                            src='{concat($new_map, local:join-string($marker, 1), $amp, "key=", $gmap-api-key)}'
                                            alt="map"/>
                                    </div>
                                    <div
                                        class="media-body media-middle">
                                        <ul
                                            class="list-inline list-unstyled">
                                            {
                                                local:constrution-button($marker, 1)
                                            }
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- Services Section -->
                <section
                    id="services"
                    class="services-section">
                    <div
                        class="container">
                        <div
                            class="row">
                            <div
                                class="col-lg-12 col-sm-12 col-md-12 col-xs-12 well well-transparent">
                                <div
                                    class="well-title">
                                    <h1>Município de Felgueiras</h1>
                                </div>
                                <div>
                                    <p
                                        class="text-justify ">"O Município de Felgueiras, localizado na parte superior do <strong>Vale do Sousa, abrange cerca de 116 Km<sup>2</sup></strong>, repartidos por 20 freguesias.
                                        É limitado a Norte por Fafe e Guimarães, a Sul por Lousada e Amarante, a Poente por Vizela e a Nascente por Celorico de Basto.
                                        A cidade de Felgueiras dista do Porto 53 Km, de Braga 39 km, de Celorico de Basto 30 Km, de Guimarães 17 Km, de Amarante 18 Km, de Lousada 14 Km, de Fafe 13 Km e de Vizela 12 Km.</p>
                                    
                                    <p>É constituído por quatro centros urbanos: a <strong>Cidade de Felgueiras</strong>, a <strong>Cidade da Lixa</strong>, a <strong>Vila de Barrosas</strong> e a <strong>Vila da Longra</strong>. Verdadeiro coração da NUT Tâmega, constitui hoje uma centralidade importante no mapa de auto-estradas e itinerários principais, uma garantia sólida de afirmação das inúmeras potencialidades reais concelhias.</p>
                                    
                                    <p>O património monumental do concelho é rico e diverso, sendo de realçar no presente e entre outros, o que se integra na <strong>Rota do Românico do Vale do Sousa: Mosteiro de Pombeiro, Igreja de Airães, Igreja de Sousa, Igreja de Unhão e a Igreja de S. Mamede em Vila Verde.</strong>"</p>
                                    <p
                                        class="text-right"> - <a
                                            href="http://www.cm-felgueiras.pt/pt">Municipio de Felgueiras</a></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- Contact Section -->
                <!-- Modal -->
                <div
                    class="modal fade"
                    id="login"
                    role="dialog">
                    <div
                        class="modal-dialog ">
                        <div
                            class="modal-content">
                            <div
                                class="modal-header text-center">
                                <button
                                    type="button"
                                    class="close"
                                    data-dismiss="modal">×</button>
                                <h4
                                    class="modal-title">Login</h4>
                            </div>
                            <div
                                class="modal-body">
                                <xf:model
                                    id="modelUser"
                                    schema="http://localhost:8887/exist/rest/apps/LocaisTuristicos/data/Funcionarios/funcionario.xsd">
                                    <xf:instance
                                        id="instanceUser"
                                        src="http://localhost:8887/exist/rest/apps/LocaisTuristicos/data/Funcionarios/funcionario.xml"/>
                                    <xf:bind
                                        id="user"
                                        nodeset="//funcionario:username"
                                        required="true()"
                                        type="common:usernameType"/>
                                    <xf:bind
                                        id="password"
                                        nodeset="//funcionario:password"
                                        type="common:passwordType"
                                        required="true()"/>
                                    <xf:submission
                                        action="http://localhost:8887/exist/rest/db/apps/LocaisTuristicos/logic/Publico/login.xquery"
                                        id="login_submission"
                                        method="post"/>
                                </xf:model>
                                <div
                                    class="xfSubmit">
                                    <xf:input
                                        class="input-group"
                                        bind="user">                                        
                                        <xf:label
                                            class="input-group-addon"><i
                                                class="glyphicon glyphicon-user"></i> Username</xf:label>
                                    </xf:input>
                                </div>
                                
                                <div
                                    class="xfSubmit">
                                    <xf:secret
                                        class="input-group"
                                        bind="password">
                                        <xf:label
                                            class="input-group-addon"><i
                                                class="glyphicon glyphicon-lock"></i> Password</xf:label>
                                    </xf:secret>
                                </div>
                                <div
                                    class="text-center">
                                    <xf:submit
                                        submission="login_submission">
                                        <xf:label>Login</xf:label>
                                    </xf:submit>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- jQuery -->
                <script
                    src="resources/js/jquery.js"></script>
                <!-- Bootstrap Core JavaScript -->
                <script
                    src="resources/js/bootstrap.min.js"></script>
                <!-- Scrolling Nav JavaScript -->
                <script
                    src="resources/js/jquery.easing.min.js"></script>
                <script
                    src="resources/js/scrolling-nav.js"></script>
            </body>
        </html>
};

 local:initPage()
        


