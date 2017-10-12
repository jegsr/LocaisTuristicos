import module namespace http = "http://exist-db.org/xquery/httpclient";
import module namespace util = "http://exist-db.org/xquery/util";
import module namespace error = 'http://www.example.com/error' at '../partials/error.xquery';
import module namespace menu = 'http://www.example.com/menu' at '../partials/menu.xquery';
declare namespace session = "http://exist-db.org/xquery/session";

declare option exist:serialize "method=xhtml media-type=text/html";


declare function local:initDetalhes() as node(){
(: Efectuar o login na BD :)
let $user := session:get-attribute('user')
let $pwd := session:get-attribute('pass')
let $login := xmldb:login('xmldb:exist:///db/apps/LocaisTuristicos', $user, $pwd)

let $param := request:get-parameter("id", "")
let $spreadsheet-url := 'https://docs.google.com/spreadsheets/d/1jEi_hkpR4RdEGcM2Glgxm5xylQGOaCOYRAxtNUXOJX0/gviz/tq?tqx=out:json'
let $spreadsheet-response := http:get(xs:anyURI($spreadsheet-url), true(), <Headers/>)

let $body := util:base64-decode($spreadsheet-response/httpclient:body/text())

let $x := parse-json(substring-before(substring-after($body, '('), ');'))

let $odk-server := "https://pei-trabalho.appspot.com"

let $amp := "&amp;"
let $gmap-api-key := 'AIzaSyDjL0B5IDSL8Rc-pZ00-rML06CEMAzfedg'


let $type := session:get-attribute("userType")

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
        
        <!-- The #page-top ID is part of the scrolling feature - the data-spy and data-target are part of the built-in Bootstrap scrollspy function -->
        
        <body
            id="page-top"
            data-spy="scroll"
            data-target=".navbar-fixed-top">
            <!-- Navigation -->
            {
                if ($type = 'admin') then
                    menu:top-menu-admin($user, "http://localhost:8887/exist/apps/LocaisTuristicos/templates/Privado/mapa.xquery","../../resources")
                else
                    (
                    menu:top-menu-funcionario($user, "http://localhost:8887/exist/apps/LocaisTuristicos/templates/Privado/mapa.xquery","../../resources")
                    )
            }
            
            <section
                id="intro"
                class="intro-section">
                <div
                    class="container">
                    {
                    
               for $data in $x?table?rows?*
                    where $data?c(1)?v eq $param
                        let $latitude := $data?c(10)?v
                        let $longitude := $data?c(11)?v
                        let $map-url := concat("https://maps.googleapis.com/maps/api/staticmap?center=",$latitude,",",$longitude,$amp,"zoom=14",$amp,"size=400x400",$amp,"markers=color:blue|",$latitude,",",$longitude,$amp,"key=",$gmap-api-key)
                        let $name := $data?c(8)?v
                        let $date := $data?c(6)?v
                        let $nomeFuncionario := $data?c(15)?v
                        let $email := $data?c(16)?v
                        let $image := replace($data?c(9)?v,"http://aggregate.defaultdomain",$odk-server)
                        return 
                    <div
                        class="row">
                        <div
                            class="col-lg-12 col-sm-10 col-xs-10 col-md-12 well well-transparent">
                            <div
                                class="well-title">
                                <h1>Ponto Turístico Temporario</h1>
                            </div>
                            <div
                                class="media">
                                <div
                                    class="media-left">
                                    <img
                                        src="{$map-url}"></img>
                                </div>
                                <div class="media-body ">
                                <div class="row ">
                                <div class="col-lg-7 col-sm-6 col-xs-6 col-md-7 text-left">
                                   <xf:model id="modelFormulario" schema="http://localhost:8887/exist/apps/LocaisTuristicos/data/Locais/local.xsd">
      
      
          <xf:instance id="instanceData">
        <formulario:local>
                 <formulario:id>{$param}</formulario:id>
                 <formulario:email>{$email}</formulario:email>
                 <formulario:data>{$date}</formulario:data>
                 <formulario:foto>{$image}</formulario:foto>
                 <formulario:nomeLocal>{$name}</formulario:nomeLocal>
                 <formulario:nomeFuncionario>{$nomeFuncionario}</formulario:nomeFuncionario>
                 <formulario:latitude>{$latitude}</formulario:latitude>
                 <formulario:longitude>{$longitude}</formulario:longitude>
      </formulario:local>
      </xf:instance>
      <xf:bind id="id" nodeset="//formulario:id" type="common:idType"  readonly="true()"/>
      <xf:bind id="email" nodeset="//formulario:email" type="common:emailType" required="true()" />
      <xf:bind id="data" nodeset="//formulario:data" type="xs:string"  readonly="true()"/>
      <xf:bind id="foto" nodeset="//formulario:foto" type="common:urlType"required="true()" />
      <xf:bind id="nomeLocal" nodeset="//formulario:nomeLocal" type="common:stringMediaType" required="true()"/>
      <xf:bind id="nomeFuncionario" nodeset="//formulario:nomeFuncionario" type="common:stringPequenaType" required="true()"/>
      <xf:bind id="latitude" nodeset="//formulario:latitude" type="common:coordenadasType" required="true()"/>
      <xf:bind id="longitude" nodeset="//formulario:longitude" type="common:coordenadasType" required="true()"/>
      <xf:submission action="http://localhost:8887/exist/rest/db/apps/LocaisTuristicos/logic/Funcionario/aprovar.xquery" id="aprovar1" method="post"/>
         <xf:submission action="http://localhost:8887/exist/rest/db/apps/LocaisTuristicos/logic/Funcionario/rejeitar.xquery" id="rejeitar1" validate="false" method="post"/>
    </xf:model>  
                                     <div
                                    class="xfSubmit">
                                    <xf:input
                                        class="input-group"
                                        bind="id">
                                        <xf:label class="input-group-addon">ID: </xf:label>
                                    </xf:input>
                                    </div>
                                    
                                     <div
                                    class="xfSubmit">
                                    <xf:input
                                        class="input-group"
                                        bind="data">
                                        <xf:label class="input-group-addon">Data: </xf:label>
                                    </xf:input>
                                    </div>
                                   
                                   
                                    <div
                                    class="xfSubmit">
                                    <xf:input
                                        class="input-group"
                                        bind="nomeLocal">
                                        <xf:label class="input-group-addon">Nome do Local: </xf:label>
                                    </xf:input>
                                    </div>
                                    <div
                                    class="xfSubmit">
                                    <xf:input
                                        class="input-group"
                                        bind="foto">
                                        
                                        <xf:label class="input-group-addon">Foto: </xf:label>
                                    </xf:input>
                                    </div>
                                    <div
                                    class="xfSubmit">
                                    <xf:input
                                        class="input-group"
                                        bind="latitude">
                                        <xf:label class="input-group-addon">Latitude: </xf:label>
                                    </xf:input>
                                    </div>
                                    <div
                                    class="xfSubmit">
                                    <xf:input
                                        class="input-group"
                                        bind="longitude">
                                        <xf:label class="input-group-addon">Longitude: </xf:label>
                                    </xf:input>
                                    </div>
                                    <div
                                    class="xfSubmit">
                                    <xf:input
                                        class="input-group"
                                        bind="nomeFuncionario">
                                        <xf:label class="input-group-addon">Nome do funcionario: </xf:label>
                                    </xf:input>
                                    </div>
                                    <div
                                    class="xfSubmit">
                                    <xf:input
                                        class="input-group"
                                        bind="email">
                                        <xf:label class="input-group-addon">Email: </xf:label>
                                    </xf:input>
                                    </div>
                                    
                                    </div>
                                    <div class="col-lg-5 col-sm-4 col-xs-4 col-md-5 text-right">
                                         <div class="input-group-foto text-center">
                                            <span class="label-foto">Foto do local</span>
                                            <img src='{$image}' class="imput-foto"   alt="imagem"></img>
                                         </div>
                                   </div>
                                </div>
                                
                            </div>
                            <div class="text-center">
                                <xf:submit class="btn-success"  submission="aprovar1" id="aprovar">
                                    <xf:label >Aprovar</xf:label>
                                </xf:submit>
                                <xf:submit class="btn-danger" submission="rejeitar1" id="rejeitar" >
                                    <xf:label>Rejeitar</xf:label>
                                </xf:submit>
                                </div>
                             </div>
                        </div>
                    </div>
                    }
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
                        local:initDetalhes()
                else(
                    error:no-authentification("http://localhost:8887/exist/apps/LocaisTuristicos/index.xquery","../../resources")
                )
                
    return $html