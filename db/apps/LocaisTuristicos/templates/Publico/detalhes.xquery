import module namespace http = "http://exist-db.org/xquery/httpclient";
declare namespace util="http://exist-db.org/xquery/util";
import module namespace menu = 'http://www.example.com/menu' at '../partials/menu.xquery';

declare option exist:serialize "method=xhtml media-type=text/html";

let $param := request:get-parameter("id","")


let $odk-server := "https://pei-trabalho.appspot.com"

let $amp := "&amp;"
let $gmap-api-key := 'AIzaSyDjL0B5IDSL8Rc-pZ00-rML06CEMAzfedg'


return
    
    <html
     xmlns="http://www.w3.org/1999/xhtml" 
     xmlns:common="http://mysampleapp.comum.estgf.ipp.pt"
     xmlns:funcionario="http://mysampleapp.funcionario.estgf.ipp.pt"
     xmlns:formulario="http://mysampleapp.local.estgf.ipp.pt"
     xmlns:xs="http://www.w3.org/2001/XMLSchema" 
     xmlns:xf="http://www.w3.org/2002/xforms"
     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <head>
            <title>Locais Turísticos - Felgueiras</title>
            
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
      
            <body
                id="page-top"
                data-spy="scroll"
                data-target=".navbar-fixed-top">
    
            <!-- Navigation -->
                {let $nav := if(session:get-attribute("user"))then
                                    let $typeUser := session:get-attribute("userType")
                                    let $user := session:get-attribute("user")
                                    let $nav_session :=  if($typeUser = "admin")then
                                          menu:top-menu-admin($user,"http://localhost:8887/exist/apps/LocaisTuristicos/templates/Privado/mapa.xquery","../../resources")
                                      else(
                                          menu:top-menu-funcionario($user,"http://localhost:8887/exist/apps/LocaisTuristicos/templates/Privado/mapa.xquery","../../resources")
                                      )
                                      return $nav_session
                                      else(
                                      menu:top-menu-publico("http://localhost:8887/exist/apps/LocaisTuristicos/index.xquery")
                )
                return $nav
                }
                
            <section
                id="intro"
                class="intro-section">
                <div
                    class="container">
                {
                    
               for $data in doc("/db/apps/LocaisTuristicos/data/Locais/lista-de-locaisValidos.xml")//formulario:local where $data/formulario:id[compare(., $param)=0]
                        let $latitude := $data/formulario:latitude
                        let $longitude := $data/formulario:longitude
                        let $map-url := concat("https://maps.googleapis.com/maps/api/staticmap?center=",$latitude,",",$longitude,$amp,"zoom=14",$amp,"size=400x400",$amp,"markers=color:blue|",$latitude,",",$longitude,$amp,"key=",$gmap-api-key)
                        let $name := $data/formulario:nomeLocal
                        let $date := $data/formulario:data
                        let $nomeFuncionario := $data/formulario:nomeFuncionario
                        let $email := $data/formulario:email
                        let $url_kml := concat("http://localhost:8887/exist/apps/LocaisTuristicos/data/Locais/Kml/",util:hash($data//formulario:id/string(), "md5"),".kml")
                        let $image := replace($data/formulario:foto,"http://aggregate.defaultdomain",$odk-server)
                        return 
                             <div
                        class="row">
                        <div
                            class="col-lg-12 col-sm-10 col-xs-10 col-md-12 well well-transparent">
                            <div
                                class="well-title">
                                <h1>Ponto Turístico Aprovado</h1>
                            </div>
                            <div
                                class="media">
                                <div
                                    class="media-left">
                                     <img class="img-rounded " src='{$map-url}' alt="map"/>
                                    </div>
                                <div class="media-body text-center">                                  
                                    <div class="row ">
                                    <div class="col-lg-7 col-sm-6 col-xs-6 col-md-7 text-left">
                                        <div class="input-group">
                                        <span class="input-group-addon">Nome do local</span>
                                        <div  class="form-control"  >{$name}</div>
                                      </div>
                                       <div class="input-group">
                                        <span class="input-group-addon">Latitude</span>
                                        <div  class="form-control"  > {$latitude}</div>
                                      </div>
                                         <div class="input-group">
                                        <span class="input-group-addon">Longitude</span>
                                        <div  class="form-control"  > {$longitude}</div>
                                      </div>
                                       <div class="input-group">
                                        <span class="input-group-addon">Nome do funcionario</span>
                                        <div  class="form-control"  > {$nomeFuncionario}</div>
                                      </div>
                                      <div class="input-group">
                                        <span class="input-group-addon">Email</span>
                                        <div  class="form-control"  > {$email}</div>
                                      </div>
                                      <a class="btn btn-download input-group " href="{$url_kml}" download="{concat($name,".kml")}">
                                      Download KML
                                      </a>
                                    </div>
                                   
                                    <div class="col-lg-5 col-sm-4 col-xs-4 col-md-5 text-right">
                                            <div class="input-group-foto text-center">
                                            <span class="label-foto">Foto do local</span>
                                            <img src='{$image}' class="imput-foto"   alt="imagem"/>
                                          </div>
                                        
                                         
                                        
                                    </div>
                                    </div>
                           
                            
                                  
                            
                              
                             
                                    </div>
                                    
                            </div>
                                <div class="text-center">
                                 <a href="http://localhost:8887/exist/apps/LocaisTuristicos/index.xquery" id="btn-bootstrap" class="btn btn-primary">Voltar</a>
                                 </div>
                        </div>
                    </div>
                                    
                                    
                                    
                                    
                             
                           
                }
                    
             </div>
            </section>
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
                                        bind="user"
                                        >
                                        <xf:label
                                            class="input-group-addon"><i
                                                class="glyphicon glyphicon-user"></i> Username</xf:label>
                                    </xf:input>
                                </div>
                                
                                <div
                                    class="xfSubmit">
                                    <xf:secret
                                        class="input-group"
                                        bind="password"
                                        >
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
