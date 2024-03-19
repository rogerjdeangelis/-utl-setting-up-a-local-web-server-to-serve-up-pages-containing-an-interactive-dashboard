%let pgm=utl-setting-up-a-local-web-server-to-serve-up-pages-containing-an-interactive-dashboard;

Setting up a local web server to serve up pages containing an interactive dashboard

github
https://tinyurl.com/3dsavkjj
https://github.com/rogerjdeangelis/-utl-setting-up-a-local-web-server-to-serve-up-pages-containing-an-interactive-dashboard

Source for this post
https://github.com/RamiKrispin/shinylive-r?tab=readme-ov-file

Static image of the intractive page produced by the code below
https://tinyurl.com/3cxfrzyb
https://github.com/rogerjdeangelis/-utl-setting-up-a-local-web-server-to-serve-up-pages-containing-an-interactive-dashboard/blob/main/forecast.png

AS A SIDE NOTE GITHUB PROVIDES A FREE WEB PAGE SERVER

You can host your site on GitHub's github.io domain.
GitHub Pages sites are publicly available on the internet, and usage
limits apply, such as a recommended limit of 1 GB for source repositories
and a soft bandwidth limit of 100 GB per month for published sites.
I look into posting this app using the github page server.

/*   _           _     _                         _                _
  __| | __ _ ___| |__ | |__   ___   __ _ _ __ __| | __      _____| |__    _ __   __ _  __ _  ___
 / _` |/ _` / __| `_ \| `_ \ / _ \ / _` | `__/ _` | \ \ /\ / / _ \ `_ \  | `_ \ / _` |/ _` |/ _ \
| (_| | (_| \__ \ | | | |_) | (_) | (_| | | | (_| |  \ V  V /  __/ |_) | | |_) | (_| | (_| |  __/
 \__,_|\__,_|___/_| |_|_.__/ \___/ \__,_|_|  \__,_|   \_/\_/ \___|_.__/  | .__/ \__,_|\__, |\___|
                                                                         |_|          |___/
*/

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  FORCASTING  DASHBOARD                                                                                                 */
/*                                0         5        10        15        20        25                                     */
/*                             ---+---------+---------+---------+---------+---------+                                     */
/*      SELECT MODEL           |                                            FORECAST|                                    */
/*                         100 +                                            |      /+ 100                                 */
/*      +------------+         |                                            |  /\ / |                                     */
/*      |            |         |                                            | /  /  |                                     */
/*      | ARIMA      |         |                                        * * |/      |                                     */
/*      |            |         |                                     *** * *|       |                                     */
/*      +------------+         |                                  * *       |       |                                     */
/*                             |                             *  ** *        |       |                                     */
/*      ORDER PARAMETERS    50 +                           ** **            |       +  50                                 */
/*                             |                    ***   *                 |       |                                     */
/*      [X] BETA               |                   *   ***                  |       |                                     */
/*      [X] GAMMA              |             ******                         |       |                                     */
/*                             |           **                               |       |                                     */
/*      SEASONAL TYPE          |         **                                 |       |                                     */
/*                             |     ****                                   |       |                                     */
/*      +------------+       0 +    *                                       |       +   0                                 */
/*      |            |         ---+---------+---------+---------+---------+---------+                                     */
/*      | ADDITIVE   |            0         5        10        15        20        25                                     */
/*      |            |                             MPNTHS                                                                 */
/*      +------------+                                                                                                    */
/*                                                                                                                        */
/*       [ ] LOG TRANSFORMATIOM                                                                                           */
/*                                                                                                                        */
/*       FORECASTING  SLIDER MONTS                                                                                        */
/*                                                                                                                        */
/*                                                                                                                        */
/*       1   6  12  24 30 36 42 48                                                                                        */
/*      [----------               ]                                                                                       */
/*                                                                                                                        */
/**************************************************************************************************************************/


/*
 _ __  _ __ ___       _ __  _ __ ___   ___ ___  ___ ___
| `_ \| `__/ _ \_____| `_ \| `__/ _ \ / __/ _ \/ __/ __|
| |_) | | |  __/_____| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___|     | .__/|_|  \___/ \___\___||___/___/
|_|                  |_|
*/



We will use c:/temp to store setup and R code

     1.

     2. create sub directory myapp
        Either do it manually or run this code

        data _null_;
           newdir=dcreate("myapp","c:\temp");
        run;quit;

     3. Download App.R from githb to c:/temp/myapp/app.R.
        Use code below or do it manually.

        https://tinyurl.com/yjpf6waf
        https://raw.githubusercontent.com/rogerjdeangelis/-utl-setting-up-a-local-web-server-to-serve-up-pages-containing-an-interactive-dashboard/main/app.R

        * download app,R to c:/temp/myapp/app.R;
        %utlfkil("d:/temp/myapp/app.R");
        filename out "c:/temp/myapp/app.R";
        proc http
          method = 'GET'
          url    = "https://tinyurl.com/yjpf6waf"
          out    =  out;
        run;quit;


     4. Run this code to create setup files in sub direcories for the local page server.
        Because of parmcards this has to be left justified.
        You need a n internet connection

%utl_rbegin;
parmcards4;
library(shiny)
library(shinylive)
shinylive::export(appdir = "c:/temp/myapp", destdir = "c:/temp/myapp/docs")
;;;;
%utl_rend;

* RESULT;

x 'tree "c:/temp/myapp" /F /A | clip';

C:\TEMP\MYAPP
|   app.R
|
\---docs
    |   app.json
    |   index.html
    |   shinylive-sw.js
    +---edit
    |       index.html
    \---shinylive
        |   chunk-GWAOPURX.js
        |   Editor.css
        |   ...
        \---webr
            |   esbuild.d.ts
            |   libRblas.so
            |   libRlapack.so
            |   ...
            +---repl
            |   |   App.d.ts
            |   |
            |   \---components
            |           Editor.d.ts
            |           Files.d.ts
            |           ...
            +---tests
            |   +---packages
            |   |       webr.test.d.ts
            |   |
            |   \---webR
            |       |   console.test.d.ts
            |       |   error.test.d.ts
            |       |   ...
            |       \---chan
            |               channel-postmessage.test.d.ts
            +---vfs
            |   +---etc
            |   |   \---fonts
            |   |           fonts.conf
            |   +---usr
            |   |   +---lib
            |   |   |   \---R
            |   |   |       |   doc.data
            |   |   |       |   doc.js.metadata
            |   |   |       |   ....
            |   |   |       \---library
            |   |   |           ...
            |   |   \---share
            |   |       |   ...
            |   |       \---fonts
            |   |           ...
            |   \---var
            |       \---cache
            |           \---fontconfig
            \---webR
                |   compat.d.ts
                |   ...
                \---chan
                        ....
/*         _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| `_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

*/

/*----                                                                   ----*/
/*---- first droop down starts a persistent local server                 ----*/
/*----                                                                   ----*/

filename ft15f001 clear;
%utl_rbeginx;
parmcards4;
library(shiny)
library(shinylive)
library(httpuv)
httpuv::runStaticServer("c:/temp/myapp/docs",background=TRUE,browse = interactive()) ;
;;;;
%utl_rendx;

/*----                                                                   ----*/
/*---- The sends the dashboard page to the running server                ----*/
/*----                                                                   ----*/

filename ft15f001 clear;
%utl_rbeginx;
parmcards4;
library(httpuv)
dir <- "c:/utl/docs"
host <- "127.0.0.1"
port <- 17862
browse <- TRUE
runStaticServer(dir, host, port, browse = browse)
;;;;
%utl_rendx;


/*----                                                                   ----*/
/*---- You need to manually close the server by opening the running      ----*/
/*---- command windoe (cmd.exe) and cloasing it                          ----*/
/*----                                                                   ----*/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/

