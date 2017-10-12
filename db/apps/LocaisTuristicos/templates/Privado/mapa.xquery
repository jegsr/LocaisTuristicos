import module namespace http = "http://exist-db.org/xquery/httpclient";
import module namespace util = "http://exist-db.org/xquery/util";
import module namespace menu = 'http://www.example.com/menu' at '../partials/menu.xquery';
import module namespace error = 'http://www.example.com/error' at '../partials/error.xquery';
declare namespace session = "http://exist-db.org/xquery/session";

declare namespace formulario = "http://mysampleapp.local.estgf.ipp.pt";


declare variable $cores:= (  'blue','brown','0xFFFF00', 'green', 'purple', 'yellow','gray', 'orange', 'red','white');
declare variable $coresRGB:= (  '#99b3ff','#997300','#ffff00', '#99e600', '#e699ff', '#ffd633', '#d9d9d9', '#ffaf1a', '#ff6666', 'white');

declare variable $alfanumerico:= ('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');


declare function local:join-string($numbers,$int)
{
    if($int <= count($numbers)) then
        concat("&amp;",$numbers[$int]/marker,local:join-string($numbers,$int+1))
        else()  
};


declare function local:constrution-button($numbers,$int)
{
    if($int <= count($numbers)) then
       
       <li style="display:inline">
                <a  class="btn btn-lg" href="detalhes.xquery?id={$numbers[$int]/id}"
                style="background-color:{$numbers[$int]/color}">
                {$numbers[$int]/label}
           </a> 
           
           { local:constrution-button($numbers,$int+1)}
       </li>     
       
     else()
        
      
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
      if($count < 36) then
      round($tmp*36)
      else
      round($tmp*36)+1

       
}; 

declare function local:get-Color($count)
{
      (:floor arredonda o numero por defeito:)
      (:36 é o maximo de posiçoes de caracteres alfa-numericos:)
      (:dividimos para conseguir identificar a proporçao direta entre o contador e o numero maximo:)
      (:para depois acharmos a posiçao entre [0-36]:)
      (:ex.: floor(2.22)= 2:)
     floor($count div 36)+1
}; 

declare option exist:serialize "method=xhtml media-type=text/html indent=yes";

declare function local:search($query as xs:string,$query1 as xs:string) {

let $new_map := "https://maps.googleapis.com/maps/api/staticmap?autoscale=1&amp;size=600x600&amp;maptype=hybrid"
 
let $spreadsheet-url := 'https://docs.google.com/spreadsheets/d/1jEi_hkpR4RdEGcM2Glgxm5xylQGOaCOYRAxtNUXOJX0/gviz/tq?tqx=out:json'
let $spreadsheet-response := http:get(xs:anyURI($spreadsheet-url), true(), <Headers/>)

let $body := util:base64-decode($spreadsheet-response/httpclient:body/text())

let $x := parse-json(substring-before(substring-after($body, '('), ');'))

let $odk-server := "https://pei-trabalho.appspot.com"

let $amp := "&amp;"

let $gmap-api-key := 'AIzaSyDjL0B5IDSL8Rc-pZ00-rML06CEMAzfedg'
let $user := session:get-attribute("user")
let $type := session:get-attribute("userType")

return let $dataSelection := if ($query and $query1="" ) then
                
                      let $dataSelection := for $data in $x?table?rows?* where count(collection("/db/apps/LocaisTuristicos/data/Locais")//formulario:local/formulario:id[text() =  $data?c(1)?v]) = 0 and ($data?c(15)?v[contains(., $query)] or $data?c(8)?v[contains(., $query)] or $data?c(14)?v[contains(., $query)] or $data?c(16)?v[contains(., $query)])
                              let $id := $data?c(1)?v
                              let $latitude := $data?c(10)?v
                              let $longitude := $data?c(11)?v
                              let $nomeFuncionario := $data?c(15)?v
                          return <formulario>
                               <id>{$id}</id>
                               <nomeFuncionario>{$nomeFuncionario}</nomeFuncionario>
                               <latitude>{$latitude}</latitude>
                               <longitude>{$longitude}</longitude>
                          </formulario>
                  return $dataSelection

    else(
             let $dataSelection := if ($query1 and $query="") then
                               let $dataSelection := for $data in $x?table?rows?* where count(collection("/db/apps/LocaisTuristicos/data/Locais")//formulario:local/formulario:id[text() =  $data?c(1)?v]) = 0 and ($data?c(15)?v[compare(., $query1)=0])
                                           let $id := $data?c(1)?v
                                           let $latitude := $data?c(10)?v
                                           let $longitude := $data?c(11)?v
                                           let $nomeFuncionario := $data?c(15)?v
                                       return <formulario>
                                            <id>{$id}</id>
                                            <nomeFuncionario>{$nomeFuncionario}</nomeFuncionario>
                                            <latitude>{$latitude}</latitude>
                                            <longitude>{$longitude}</longitude>
                                       </formulario>
                               return $dataSelection
             
             else(
                    let $dataSelection := if ($query1 and $query) then
                                    let $dataSelection := for $data in $x?table?rows?* where count(collection("/db/apps/LocaisTuristicos/data/Locais")//formulario:local/formulario:id[text() =  $data?c(1)?v]) = 0 and $data?c(15)?v[compare(., $query1)=0] and ($data?c(8)?v[contains(., $query)] or $data?c(14)?v[contains(., $query)] or $data?c(16)?v[contains(., $query)])
                                                let $id := $data?c(1)?v
                                                let $latitude := $data?c(10)?v
                                                let $longitude := $data?c(11)?v
                                                let $nomeFuncionario := $data?c(15)?v
                                            return <formulario>
                                                 <id>{$id}</id>
                                                 <nomeFuncionario>{$nomeFuncionario}</nomeFuncionario>
                                                 <latitude>{$latitude}</latitude>
                                                 <longitude>{$longitude}</longitude>
                                            </formulario>
                                    return $dataSelection
                     else(
                            let $dataSelection := for $data in $x?table?rows?* where count(collection("/db/apps/LocaisTuristicos/data/Locais")//formulario:local/formulario:id[text() =  $data?c(1)?v]) = 0 
                                    let $id := $data?c(1)?v
                                    let $latitude := $data?c(10)?v
                                    let $longitude := $data?c(11)?v
                                    let $nomeFuncionario := $data?c(15)?v
                                return <formulario>
                                     <id>{$id}</id>
                                     <nomeFuncionario>{$nomeFuncionario}</nomeFuncionario>
                                     <latitude>{$latitude}</latitude>
                                     <longitude>{$longitude}</longitude>
                                </formulario>
                                
                                return $dataSelection
               
  )
   return $dataSelection
  )
   return $dataSelection
  )
   let $marker := for $data at $count in $dataSelection
                    
                        let $label := local:get-Label($count)                        
                        let $color := local:get-Color($count)
                        let $latitude := $data/latitude
                        let $longitude := $data/longitude
                        let $map := concat("markers=color:",$cores[$color],"%7Clabel:",$alfanumerico[$label],"%7C",$latitude,",",$longitude)
                        
                        return  <object>
                                    <id>{$data/id}</id>
                                    <marker>{$map}</marker>
                                    <label>{$alfanumerico[$label]}</label>
                                    <color>{$coresRGB[$color]}</color>
                                </object>
     let $nomeFuncionario := for $data in $x?table?rows?*  where  count(collection("/db/apps/LocaisTuristicos/data/Locais")//formulario:local/formulario:id[text() =  $data?c(1)?v]) = 0
                    let $nome :=  $data?c(15)?v
                    return <nome>{$nome}</nome>
                
                
     return
     <html xmlns="http://www.w3.org/1999/xhtml" 
    xmlns:ev="http://www.w3.org/2001/xml-events"
  xmlns:common="http://mysampleapp.comum.estgf.ipp.pt"
  xmlns:funcionario="http://mysampleapp.funcionario.estgf.ipp.pt"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xf="http://www.w3.org/2002/xforms"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

  <head>

    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <title>Locais Turísticos - Felgueiras</title>

    <link rel="stylesheet" type="text/css" href="../../resources/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../../resources/css/geral.css" />
    <!-- Custom CSS -->
    <link href="../../resources/css/scrolling-nav.css" rel="stylesheet" />
    <link href="../../resources/css/detalhes.css" rel="stylesheet" />



  </head>

  <!-- The #page-top ID is part of the scrolling feature - the data-spy and data-target are part of the built-in Bootstrap scrollspy function -->

  <body id="page-top" data-spy="scroll" data-target=".navbar-fixed-top">
    <!-- Navigation -->
    {
        if($type = "admin")then
            menu:top-menu-admin($user,"","../../resources")
        else(
            menu:top-menu-funcionario($user,"","../../resources")
        )
    }
    
    <section id="intro" class="intro-section">
      <div class="container">
        <div class="row">
          <div class="col-lg-12 col-sm-10 col-xs-10 col-md-12 well well-transparent">

            <div class="well-title">
              <div class="row">
                <div class="col-md-5 col-sm-5 col-xs-5 ">
                  <h1 style="padding-left:25px">Locais Turísticos</h1>
                </div>
                
                
                
                                     <div  class="col-md-7 col-sm-7 col-xs-7 search" >
                  
                      <div class="input-group my-group">
                        <input type="text" id="id" class="form-control" name="id" placeholder="Pesquisar" />
                        <select id="spiner" name="spiner" class="selectpicker form-control" data-live-search="true">
                          <option value="" >Selecione um funcionario...</option>
                          { 
           for $data  in distinct-values($nomeFuncionario)
                    
                        return 
                               
                                 <option value="{$data}">{$data}</option>
                                 }
                        </select>
                        <div class="input-group-btn">
                          <button class="btn btn-default"id="search_button"><i class="glyphicon glyphicon-search"></i> Pesquisar</button>
                        </div>
                      </div>

                </div>


              </div>
            </div>

            <div class="media">
              <div class="media-left media-middle">
                <img class="img-rounded" src="{concat($new_map,local:join-string($marker,1),$amp,"key=",$gmap-api-key)}" alt="map" />
              </div>
              <div class="media-body media-middle text-center">
                <ul class="list-inline list-unstyled">
                                {
                            local:constrution-button($marker,1)
                        }
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
   
    {
        if($type = 'admin')then
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
                                    <h1>Registo de Funcionario</h1>
                                </div>
                                <div>
                                
                                    <xf:model id="modelUser" schema="http://localhost:8887/exist/apps/LocaisTuristicos/data/Funcionarios/funcionario.xsd">                                         
                                         <xf:instance  id="instanceUser" src="http://localhost:8887/exist/rest/db/apps/LocaisTuristicos/data/Funcionarios/funcionario.xml"/>
                                         
                                         <xf:bind id="username" nodeset="/funcionario:funcionario/funcionario:username" type="common:usernameType" required="true()"/>
                                         <xf:bind id="nome" nodeset="/funcionario:funcionario/funcionario:nome" type="common:stringPequenaType" required="true()"/>
                                         <xf:bind id="email" nodeset="/funcionario:funcionario/funcionario:email" type="common:emailType" required="true()"/>
                                         <xf:bind id="password" nodeset="/funcionario:funcionario/funcionario:password" type="common:passwordType" required="true()"/>
                                     
                                     <xf:submission action="http://localhost:8887/exist/rest/db/apps/LocaisTuristicos/logic/Administrador/registo.xquery" id="registar" method="post"/>
                                      
                                     
                                     </xf:model>
                                     
                                     
                                     <div class="row">
                                            <fieldset class="col-lg-12 col-sm-10 col-xs-10 col-md-12">
                                            <legend>Funcionario</legend>
                                                    <xf:input bind="username">
                                                        <xf:label>Username</xf:label>
                                                      </xf:input>
                                                      
                                                      <xf:input bind="nome">
                                                        <xf:label>Nome</xf:label>
                                                      </xf:input>  
                                                      
                                                      <xf:input bind="email">
                                                        <xf:label>Email</xf:label>
                                                      </xf:input>                                      
                                                      
                                                      <xf:secret bind="password">
                                                        <xf:label>Password</xf:label>
                                                        
                                                      </xf:secret>
                                              </fieldset>
                                       </div>
                                     
                                     
                                    
                                     
                                      <xf:submit submission="registar">
                                        <xf:label>Registar</xf:label>
                                      </xf:submit>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>       
        else()
    }
   <script type="text/javascript" src="../../resources/js/jquery.js"></script>
    <!-- Bootstrap Core JavaScript -->
    <script type="text/javascript" src="../../resources/js/bootstrap.min.js"></script>
    <!-- Scrolling Nav JavaScript -->
    <script type="text/javascript" src="../../resources/js/jquery.easing.min.js"></script>
    <script type="text/javascript" src="../../resources/js/scrolling-nav.js"></script>
  </body>
</html>


};




let $session := if (session:get-attribute("user")) then
    
    
     let $action := if(request:get-parameter("logout",()))then
                let $inval := session:invalidate()

                     return false()
                          
                    else(                    
                        let $user := session:get-attribute("user")
                        return $user 
                    )
        return $action
else
    (
    
     false()
        
    )
    
return if ($session) then
        
                let $query:=request:get-parameter("id","")
                let $query1:=request:get-parameter("spiner","")
            
                return local:search($query,$query1)
            
    
    else
        (
            if(request:get-parameter("logout",()))then
                <html>
                    <head>
                        <meta
                    http-equiv="refresh"
                    content="0; url=http://localhost:8887/exist/apps/LocaisTuristicos/index.xquery"/>
                    </head>
                </html>
            else(
                    error:no-authentification("http://localhost:8887/exist/apps/LocaisTuristicos/index.xquery","../../resources")
                )
        )


