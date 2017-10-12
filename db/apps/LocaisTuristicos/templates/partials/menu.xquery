
module namespace menu = 'http://www.example.com/menu';

declare function menu:top-menu-funcionario($user as xs:string?, $url as xs:string?, $resource as xs:string?) as node() {
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header page-scroll">
          <button type="button" class="navbar-toggle" data-toggle="collapse"
            data-target=".navbar-ex1-collapse">
            <span class="sr-only">Locais Turísticos</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand page-scroll" href="{concat($url,'#page-top')}">Home</a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
          <ul class="nav navbar-nav">
            <!-- Hidden li included to remove active class from about link when scrolled up past about section -->
            <li class="hidden">
              <a class="page-scroll" href="{concat($url,'#page-top')}"></a>
            </li>
            <li>
              <a class="page-scroll" href="{concat($url,'#intro')}">Locais Turísticos</a>
            </li>
            <li>
              <a class="page-scroll" href="http://localhost:8887/exist/apps/LocaisTuristicos/index.xquery#about">Locais Turísticos Validados</a>
            </li>

          </ul>
          <ul class="nav navbar-nav navbar-right">

            <li class="dropdown ">
              <div class="dropdown-toggle user" data-toggle="dropdown">
                <img class="img-circle img-thumbnail" src="{concat($resource,"/images/img.jpg")}"
                  alt="user" width="45px" /> {$user} <span class="caret"></span>
              </div>
              <ul class="dropdown-menu">

                <li><a href="http://localhost:8887/exist/apps/LocaisTuristicos/templates/Privado/mapa.xquery?logout='TRUE'"> Logout <span class="glyphicon glyphicon-log-out"></span>
                  </a></li>
              </ul>
            </li>

          </ul>
        </div>


        <!-- /.navbar-collapse -->
      </div>
      <!-- /.container -->
    </nav>
    
};

declare function menu:top-menu-publico($url as xs:string?) as node(){

                    <nav
                    class="navbar navbar-default navbar-fixed-top"
                    role="navigation">
                    <div
                        class="container">
                        <div
                            class="navbar-header page-scroll">
                            <button
                                type="button"
                                class="navbar-toggle"
                                data-toggle="collapse"
                                data-target=".navbar-ex1-collapse">
                                <span
                                    class="sr-only">Locais Turísticos</span>
                                <span
                                    class="icon-bar"></span>
                                <span
                                    class="icon-bar"></span>
                                <span
                                    class="icon-bar"></span>
                            </button>
                            <a
                                class="navbar-brand page-scroll"
                                href="{concat($url,"#page-top")}">Home</a>
                        </div>
                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div
                            class="collapse navbar-collapse navbar-ex1-collapse">
                            <ul
                                class="nav navbar-nav">
                                <!-- Hidden li included to remove active class from about link when scrolled up past about section -->
                                <li
                                    class="hidden">
                                    <a
                                        class="page-scroll"
                                        href="{concat($url,"#page-top")}"></a>
                                </li>
                                <li>
                                    <a
                                        class="page-scroll"
                                        href="{concat($url,"#about")}">Locais Turísticos</a>
                                </li>
                                <li>
                                    <a
                                        class="page-scroll"
                                        href="{concat($url,"#services")}">Município</a>
                                </li>
                            
                            </ul>
                            <ul
                                class="nav navbar-nav navbar-right">
                                <li>
                                    <a
                                        href="#"
                                        data-toggle="modal"
                                        data-target="#login">
                                        <span
                                            class="glyphicon glyphicon-log-in"></span> Login</a>
                                </li>
                            </ul>
                        </div>
                        
                        
                        <!-- /.navbar-collapse -->
                    </div>
                    <!-- /.container -->
                </nav>
};


declare function menu:top-menu-error($url as xs:string?) as node(){

                    <nav
                    class="navbar navbar-default navbar-fixed-top"
                    role="navigation">
                    <div
                        class="container">
                        <div
                            class="navbar-header page-scroll">
                            <button
                                type="button"
                                class="navbar-toggle"
                                data-toggle="collapse"
                                data-target=".navbar-ex1-collapse">
                                <span
                                    class="sr-only">Locais Turísticos</span>
                                <span
                                    class="icon-bar"></span>
                                <span
                                    class="icon-bar"></span>
                                <span
                                    class="icon-bar"></span>
                            </button>
                            <a
                                class="navbar-brand page-scroll"
                                href="{concat($url,"#page-top")}">Home</a>
                        </div>
                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div
                            class="collapse navbar-collapse navbar-ex1-collapse">
                            <ul
                                class="nav navbar-nav">
                                <!-- Hidden li included to remove active class from about link when scrolled up past about section -->
                                <li
                                    class="hidden">
                                    <a
                                        class="page-scroll"
                                        href="{concat($url,"#page-top")}"></a>
                                </li>
                                <li>
                                    <a
                                        class="page-scroll"
                                        href="{concat($url,"#about")}">Locais Turísticos</a>
                                </li>
                                <li>
                                    <a
                                        class="page-scroll"
                                        href="{concat($url,"#services")}">Município</a>
                                </li>
                            
                            </ul>                            
                        </div>
                        
                        
                        <!-- /.navbar-collapse -->
                    </div>
                    <!-- /.container -->
                </nav>
};


declare function menu:top-menu-admin($user as xs:string?, $url as xs:string?, $resource as xs:string?) as node()  {
    
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header page-scroll">
          <button type="button" class="navbar-toggle" data-toggle="collapse"
            data-target=".navbar-ex1-collapse">
            <span class="sr-only">Locais Turísticos</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand page-scroll" href="{concat($url,'#page-top')}">Home</a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse navbar-ex1-collapse">
          <ul class="nav navbar-nav">
            <!-- Hidden li included to remove active class from about link when scrolled up past about section -->
            <li class="hidden">
              <a class="page-scroll" href="{concat($url,'#page-top')}"></a>
            </li>
            <li>
              <a class="page-scroll" href="{concat($url,'#intro')}">Locais Turísticos</a>
            </li>
            <li>
              <a class="page-scroll" href="http://localhost:8887/exist/apps/LocaisTuristicos/index.xquery#about">Locais Turísticos Validados</a>
            </li>
            <li>
              <a class="page-scroll" href="{concat($url,'#about')}">Registo</a>
            </li>

          </ul>
          <ul class="nav navbar-nav navbar-right">

            <li class="dropdown ">
              <div class="dropdown-toggle user" data-toggle="dropdown">
                <img class="img-circle img-thumbnail" src="{concat($resource,"/images/img.jpg")}"
                  alt="user" width="45px" /> {$user} <span class="caret"></span>
              </div>
              <ul class="dropdown-menu">

                <li><a href="http://localhost:8887/exist/apps/LocaisTuristicos/templates/Privado/mapa.xquery?logout='TRUE'"> Logout <span class="glyphicon glyphicon-log-out"></span>
                  </a></li>
              </ul>
            </li>

          </ul>
        </div>


        <!-- /.navbar-collapse -->
      </div>
      <!-- /.container -->
    </nav>
};