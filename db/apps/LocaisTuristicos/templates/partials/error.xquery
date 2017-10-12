module namespace error = 'http://www.example.com/error';
import module namespace menu = 'http://www.example.com/menu' at './menu.xquery';

declare function error:no-authentification($url as xs:string?, $resource as xs:string?) as node() {
    <html  >
       <head>
                    <meta
                        http-equiv="refresh"
                        content="20; url=http://localhost:8887/exist/apps/LocaisTuristicos/index.xquery"/>
                <title>Locais Turísticos - Felgueiras</title>
                
                <link
                    rel="stylesheet"
                    type="text/css"
                    href="{concat($resource,"/css/bootstrap.min.css")}"/>
                <link
                    rel="stylesheet"
                    type="text/css"
                    href="{concat($resource,"/css/geral.css")}"/>
                <!-- Custom CSS -->
                <link
                    href="{concat($resource,"/css/scrolling-nav.css")}"
                    rel="stylesheet"/>
                <link
                    href="{concat($resource,"/css/detalhes.css")}"
                    rel="stylesheet"/>
                </head>
                
                <body id="page-top"
                data-spy="scroll"
                data-target=".navbar-fixed-top">
                 {
                    menu:top-menu-error($url)
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
                                class="col-lg-7 col-sm-8 col-md-7 col-xs-8 well well-transparent">
                                <div
                                    class="well-title">
                                    <h1><strong>Erro -</strong></h1><h2> Necessidade de efetuar autentificação</h2>
                                </div>                              
                                <div
                                    class=" text-center">
                                    <a
                                        id="btn-bootstrap"
                                        class="btn btn-danger btn-md  page-scroll"
                                        href="{$url}">Pagina Inicial</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                
                <!-- jQuery --> 
                <script
                    src="{concat($resource,"/js/jquery.js")}"></script>
                <!-- Bootstrap Core JavaScript -->
                <script
                    src="{concat($resource,"/js/bootstrap.min.js")}"></script>
                <!-- Scrolling Nav JavaScript -->
                <script
                    src="{concat($resource,"/js/jquery.easing.min.js")}"></script>
                <script
                    src="{concat($resource,"/js/scrolling-nav.js")}"></script>
                </body>
            </html>
    
};
