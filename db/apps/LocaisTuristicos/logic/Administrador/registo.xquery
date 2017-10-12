xquery version "3.0";

declare namespace system = "http://exist-db.org/xquery/system";
declare namespace exist = "http://exist.sourceforge.net/NS/exist";
declare namespace xmldb = "http://exist-db.org/xquery/xmldb";
declare namespace request = "http://exist-db.org/xquery/request";
declare namespace funcionario = "http://mysampleapp.funcionario.estgf.ipp.pt";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace session = "http://exist-db.org/xquery/session";
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";
import module namespace menu = 'http://www.example.com/menu' at '../../templates/partials/menu.xquery';
import module namespace error = 'http://www.example.com/error' at '../../templates/partials/error.xquery';

(: depois dependendo do tipo de registo, alteramos isto para pegar nas variaveis de session:)
declare function local:registar()as node(){

(: Efectuar o login na BD :)
let $user := session:get-attribute('user')
let $pwd := session:get-attribute('pass')
let $login := xmldb:login('xmldb:exist:///db/apps/LocaisTuristicos', $user, $pwd)

let $dataFile := doc('/db/apps/LocaisTuristicos/data/Funcionarios/lista-de-funcionarios.xml')

let $var := request:get-data()
let $user := $var//funcionario:username
let $pass := $var//funcionario:password
let $nome := $var//funcionario:nome
let $email := $var//funcionario:email
let $typeUser := "Funcionario"


let $type := session:get-attribute("userType")

return
        let $dataPass :=  util:hash($pass,"sha1")
        
        let $var1 := <funcionario:funcionario >
                        <funcionario:username>{$user}</funcionario:username>
                        <funcionario:nome>{$nome}</funcionario:nome>
                        <funcionario:email>{$email}</funcionario:email>
                        <funcionario:password>{$dataPass}</funcionario:password>
                    </funcionario:funcionario>
                  
        (:E PRECISO SUBSTITUIR A PASS QUE SE VAI GUARDAR EM FICHEIRO PELA ENCRIPTADA:)
        
        (: responsavel por inserir o utilizador se nao existir ou realizar a substituiçao se existir :)
        let $data := if (exists($dataFile//funcionario:funcionario[funcionario:username/text() = $user]))then
                        update replace $dataFile//funcionario:funcionario[funcionario:username/text()=$user] with $var1 
                        
            else update insert $var into $dataFile/funcionario:listaDeFuncionarios

       let $s := if(sm:user-exists($user))then
           sm:remove-account($user)
         else ()  
        
        let $createUser := sm:create-account($user, $pass, $typeUser)       
        
        return 
       <html
        xmlns="http://www.w3.org/1999/xhtml"
        xmlns:ev="http://www.w3.org/2001/xml-events"
        xmlns:common="http://mysampleapp.comum.estgf.ipp.pt"
         xmlns:formulario="http://mysampleapp.local.estgf.ipp.pt"
        xmlns:xs="http://www.w3.org/2001/XMLSchema"
        xmlns:xf="http://www.w3.org/2002/xforms"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        
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
            
             <meta http-equiv="refresh" content="30;url=http://localhost:8887/exist/apps/LocaisTuristicos/templates/Privado/mapa.xquery" />
            
            <title>Scrolling Nav - Start Bootstrap Template</title>
            
            <link
                rel="stylesheet"
                type="text/css"
                href="../../resources/css/bootstrap.min.css"/>
            <link
                rel="stylesheet"
                type="text/css"
                href="../../resources/css/geral.css"/>
            <!-- Custom CSS -->
            <link
                href="../../resources/css/scrolling-nav.css"
                rel="stylesheet"/>
            <link
                href="../../resources/css/detalhes.css"
                rel="stylesheet"/>
        
        
        
        </head>
        
        <!-- The #page-top ID is part of the scrolling feature - the data-spy and data-target are part of the built-in Bootstrap scrollspy function -->
        
        <body
            id="page-top"
            data-spy="scroll"
            data-target=".navbar-fixed-top">
            <!-- Navigation -->
            {
               
                    menu:top-menu-admin($user, "http://localhost:8887/exist/apps/LocaisTuristicos/templates/Privado/mapa.xquery","../../resources")
                
            }
            
             <section
                id="intro"
                class="intro-section">
                <div
                    class="container">
                      <div
                        class="row">
                        <div
                            class="col-lg-12 col-sm-10 col-xs-10 col-md-12 well well-transparent ">
                            <div
                                class="well-title">
                                <h1>Registo de funionário</h1>
                            </div>
                            
                            <div class="text-center">
                           
			                     <h3>Funcionário registado com Sucesso!</h3>
			                 
			                         <a href="http://localhost:8887/exist/apps/LocaisTuristicos/templates/Privado/mapa.xquery" class="btn btn-success">Voltar</a>
                            </div>
                            
                            </div>
			 </div>
			</div>
			</section>
			  <script
                type="text/javascript"
                src="../../resources/js/jquery.js"></script>
            <!-- Bootstrap Core JavaScript -->
            <script
                type="text/javascript"
                src="../../resources/js/bootstrap.min.js"></script>
            <!-- Scrolling Nav JavaScript -->
            <script
                type="text/javascript"
                src="../../resources/js/jquery.easing.min.js"></script>
            <script
                type="text/javascript"
                src="../../resources/js/scrolling-nav.js"></script>
		</body>
	</html>
	};
	let $html : = if(session:get-attribute("user"))then
	                 let $type := session:get-attribute("userType")
	                 let $regist := if($type = 'admin')then
                            local:registar()
                       else(
                            error:no-authentification("http://localhost:8887/exist/apps/LocaisTuristicos/index.xquery","../../resources")
                       )
                       return $regist
                else(
                    error:no-authentification("http://localhost:8887/exist/apps/LocaisTuristicos/index.xquery","../../resources")
                )
                
    return $html