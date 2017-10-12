xquery version "3.0";

declare namespace system="http://exist-db.org/xquery/system";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace formulario="http://mysampleapp.local.estgf.ipp.pt";
declare namespace validate = "http://exist-db.org/xquery/validation";
declare namespace util="http://exist-db.org/xquery/util";
declare namespace sm="http://exist-db.org/xquery/securitymanager";

import module namespace error = 'http://www.example.com/error' at '../../templates/partials/error.xquery';
import module namespace menu = 'http://www.example.com/menu' at '../../templates/partials/menu.xquery';

(: o output irá ser apresentado com xhtml :)
declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

declare function local:createKML($dadosDoFormulario as node())as xs:string?{

    let $contentKml := <kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">
    <Document>
        <name>{$dadosDoFormulario//formulario:nomeLocal/text()}</name>
        <Style id="carousel_n">
            <IconStyle>
                <scale>1.1</scale>
                <Icon>
                    <href>https://earth.google.com/clientassets/pin_myplaces_selected_128px.png</href>
                </Icon>
                <hotSpot x="0.5" y="0" xunits="fraction" yunits="fraction"/>
                <gx:scalingMode>fixedScaling</gx:scalingMode>
            </IconStyle>
            <LabelStyle>
                <scale>0</scale>
            </LabelStyle>
            <BalloonStyle>
                <text><![CDATA[<!DOCTYPE html><html><head><meta charset="UTF-8" /><title>Google Earth 480-wide panel with a YouTube video, dark theme</title><meta name="viewport" content="width=device-width, initial-scale=1.0" /><link rel="stylesheet" href="https://storage.googleapis.com/geteachkml4/scripts/tourFont.css" type="text/css" /><link rel="stylesheet" href="https://storage.googleapis.com/geteachkml4/scripts/grey_light_blue.css" /><link rel="stylesheet" href="https://storage.googleapis.com/geteachkml4/scripts/earthFeed0115.css" type="text/css" /> <script src="https://storage.googleapis.com/geteachkml4/scripts/all_js_compiled.js"></script></head><body><div class="ef-container ef-480-width theme-dark ef-panel mdl-layout mdl-js-layout"><main class="ef-content mdl-layout__content"><div class="carousel carousel--with-fab"><div class="carousel__buttons carousel__buttons--dark"><a href="#" class="carousel__buttons__button--prev mdl-button mdl-button--icon mdl-js-button"><i class="carousel-button__icon material-icons">&#xE408;</i></a><a href="#" class="carousel__buttons__button--next mdl-button mdl-button--icon mdl-js-button"><i class="carousel-button__icon material-icons">&#xE409;</i></a></div><a href="#$[id]_ilb;balloon" class="ef-figure__zoom"><span class="ef-figure__button mdl-button mdl-button--icon mdl-js-button"><i class="ef-figure__icon material-icons">&#xE5D0;</i></span></a></div><a href="#$[id];flyto" class="ef-container__button ef-container__button--flyto u-button u-button--over-carousel mdl-button mdl-js-button mdl-button--fab mdl-button--colored mdl-js-ripple-effect"><svg width="48" height="48" viewBox="0 0 48 48" xmlns="http://www.w3.org/2000/svg"><path d="M42.506 8.25c.106-.027.21-.04.312-.04.78 0 1.39.78 1.115 1.574L36.81 37.502c-.172.5-.638.802-1.125.802-.194 0-.39-.048-.576-.15L25.1 32.7l-6.967 7.028c-.68.7-2.11-.018-2.11-.993v-10.74L4.61 21.75c-.932-.52-.76-1.91.272-2.186L42.506 8.25zM19.05 27.08v7.084l21.3-22.33v-.146L19.05 27.08z" fill="#FFF" fill-rule="evenodd"/></svg></a><div class="ef-padding ef-padding--with-fab"><h1 class="ef-content__title">$[name]</h1><h2 class="ef-content__subhead">$[snippet]</h2></div><div class="ef-padding"><div class="ef-content__container"><div class="ef-content__description"><p>$[description]</p></div></div></div></main></div><script src="https://storage.googleapis.com/geteachkml4/scripts/earthfeed008.js"></script><script> let remoteScript = document.createElement("script"); remoteScript.setAttribute("src", "https://storage.googleapis.com/geteachkml4/scripts/earthfeed008.js"); document.body.appendChild(remoteScript); </script><script> var sampleData = $[carousel_data]; var sampleDataAsString = JSON.stringify(sampleData); setTimeout(function() { var carousel = new PanelsCarousel(sampleDataAsString); }.bind(this), 1000); </script></body></html>]]></text>
                <bgColor>ff383226</bgColor>
                <gx:displayMode>panel</gx:displayMode>
            </BalloonStyle>
            <ListStyle>
                <ItemIcon>
                    <href>https://earth.google.com/clientassets/pin_myplaces_selected_128px.png</href>
                </ItemIcon>
            </ListStyle>
        </Style>        
        <Placemark id="placemark_0">
            <name>{$dadosDoFormulario//formulario:nomeLocal/text()}</name>
            <snippet>Felgueiras, Portugal</snippet>
            <description></description>
            <LookAt>
                <longitude>{$dadosDoFormulario//formulario:longitude/text()}</longitude>
                <latitude>{$dadosDoFormulario//formulario:latitude/text()}</latitude>
                <altitude>0</altitude>
                <heading>0</heading>
                <tilt>45</tilt>
                <gx:fovy>35</gx:fovy>
                <range>87.377450714597</range>
                <altitudeMode>relativeToGround</altitudeMode>
            </LookAt>
            <styleUrl>#carousel_n</styleUrl>
            <ExtendedData>
                <Data name="image_caption">
                </Data>
                <Data name="carousel_data">
                    <value>{concat("{&quot;images&quot;: [ {&quot;url&quot;: &quot;",$dadosDoFormulario//formulario:foto/text(),"&quot;, &quot;caption&quot;: &quot; &quot;}]}")}</value>
                </Data>
            </ExtendedData>
            <Point>
                <coordinates>{$dadosDoFormulario//formulario:longitude/text()},{$dadosDoFormulario//formulario:latitude/text()},0</coordinates>
            </Point>
        </Placemark>
    </Document>
</kml>
    
    let $name := util:hash($dadosDoFormulario//formulario:id/string(), "md5")  
    let $store := xmldb:store("/db/apps/LocaisTuristicos/data/Locais/Kml",concat($name,".kml"),$contentKml)
    let $parent-chmod := sm:chmod($store, 'rwxr-xr-x')
    return $store
};

declare function local:aprovar($dadosDoFormulario as node() ) as node(){
(: Efectuar o login na BD :) 
let $user := session:get-attribute('user')
let $type := session:get-attribute("userType")
let $pwd := session:get-attribute('pass')
let $login := xmldb:login('xmldb:exist:///db/apps/LocaisTuristicos', $user, $pwd)




let $dataFile := doc('/db/apps/LocaisTuristicos/data/Locais/lista-de-locaisValidos.xml')
let $data:= update insert $dadosDoFormulario into $dataFile/formulario:listaDeLocais

let $store := local:createKML($dadosDoFormulario)


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
                      <div
                        class="row">
                        <div
                            class="col-lg-12 col-sm-10 col-xs-10 col-md-12 well well-transparent">
                            <div
                                class="well-title">
                                <h1>Ponto Turístico Temporario</h1>
                            </div>
                            
                            <div class="text-center">
                           
			                     <h3>Aprovado com Sucesso!</h3>
			                 
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
                      (: ler todos os dados que foram introduzidos:)
                        let $dadosDoFormulario := request:get-data()
                        let $schema := doc("/db/apps/LocaisTuristicos/data/Locais/local.xsd")
                        
                        let $user := session:get-attribute('user')
                        let $type := session:get-attribute("userType")
                        let $returnAprovar := if (validate:jaxv($dadosDoFormulario,$schema))then
                            local:aprovar($dadosDoFormulario)
                        else(
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
                      <div
                        class="row">
                        <div
                            class="col-lg-12 col-sm-10 col-xs-10 col-md-12 well well-transparent">
                            <div
                                class="well-title">
                                <h1>Ponto Turístico Temporario</h1>
                            </div>
                            
                            <div>
			                     <h3>Impossibilidade de aprovação!</h3>
			                     <p>Os dados enviados para aprovação não são os esperados. Por favor submeta-os novamente para aprovação </p>
			                         <a href="{concat("http://localhost:8887/exist/apps/LocaisTuristicos/templates/Privado/detalhes.xquery?id=",$dadosDoFormulario//formulario:id)}" class="btn btn-warning">Voltar</a>
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
                        
                        )
                      return $returnAprovar
                else(
                    error:no-authentification("http://localhost:8887/exist/apps/LocaisTuristicos/index.xquery","../../resources")
                )
                
    return $html