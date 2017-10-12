xquery version "3.0";

declare namespace system = "http://exist-db.org/xquery/system";
declare namespace exist = "http://exist.sourceforge.net/NS/exist";
declare namespace xmldb = "http://exist-db.org/xquery/xmldb";
declare namespace session = "http://exist-db.org/xquery/session";
declare namespace request = "http://exist-db.org/xquery/request";
declare namespace funcionario = "http://mysampleapp.funcionario.estgf.ipp.pt";

import module namespace menu = 'http://www.example.com/menu' at '../../templates/partials/menu.xquery';
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

let $var := request:get-data()
let $user := $var//funcionario:username
let $pass := $var//funcionario:password


let $login := xmldb:login('/db/apps/LocaisTuristicos', $user, $pass)

return
    if ($login) then
        let $session := session:create()
        
        (:pegar no user atual:)
        let $currentUser := xmldb:get-current-user()
        (:pegar no grupo que é equivalente ao tipo de utilizaodr:)
        let $userType := xmldb:get-user-groups($currentUser)
        
        (:guardar as variaveis na session:)
        let $session_atribute := session:set-attribute("user", $user)
        let $session_atribute2 := session:set-attribute("pass", $pass)
        
         let $session_atribute3 := session:set-attribute("userType", $userType)
                           
                            
        return if($user = "admin") then
        <html>
        <head>        
            <meta http-equiv="refresh" content="0; url=http://localhost:8887/exist/apps/LocaisTuristicos/templates/Privado/mapa.xquery" />
        </head>
       </html>  
        else(
        <html>
        <head>
            <meta http-equiv="refresh" content="0; url=http://localhost:8887/exist/apps/LocaisTuristicos/templates/Privado/mapa.xquery" />
        </head>
       </html>        
        )
        
    else(
       <html>
        <head>
            <title>Locais Turísticos - Felgueiras</title>
            <meta http-equiv="refresh" content="20; url=http://localhost:8887/exist/apps/LocaisTuristicos/index.xquery" />
             
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
            
            {menu:top-menu-error("http://localhost:8887/exist/apps/LocaisTuristicos/index.xquery")}
            
           <section
                id="intro"
                class="intro-section">
                <div
                    class="container">
                      <div
                        class="row">
                        <div
                            class="col-lg-12 col-sm-10 col-xs-10 col-md-12 well well-transparent">
                            <div
                                class="well-title">
                                <h1>Login Invalido</h1>
                            </div>
                            
                            <div>
                           
			                     <h3>Os dados de autentificação introduzidos são invalidos</h3>
			                     <a href="http://localhost:8887/exist/apps/LocaisTuristicos/index.xquery" class="btn btn-warning">Voltar</a>
                            </div>
                            
                            </div>
			 </div>
			</div>
			</section>
			  <script
                type="text/javascript"
                src="resources/js/jquery.js"></script>
            <!-- Bootstrap Core JavaScript -->
            <script
                type="text/javascript"
                src="resources/js/bootstrap.min.js"></script>
            <!-- Scrolling Nav JavaScript -->
            <script
                type="text/javascript"
                src="resources/js/jquery.easing.min.js"></script>
            <script
                type="text/javascript"
                src="resources/js/scrolling-nav.js"></script>
		</body>
       </html>)