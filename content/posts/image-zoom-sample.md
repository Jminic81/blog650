---
author: "Judy Minichelli"
date: 2017-09-22
linktitle: R Dot Plot
title: R Dot Plot
weight: 10
---

#How to use an R dot plot to display Lahman database stats.

Comparing number of career homeruns vs. strike outs for all Players (Figure 1). 

Dot plot was formated so that hover feature produces first and last name of player at each data point (Figure 2, 3)

R:image=posts/images/"fig1.jpg"
R:image=posts/images/"fig2.jpg"
R:image=posts/images/"fig3.jpg"

R Studio commands: 

> install.packages("Lahman")
> library("dplyr", lib.loc="~/R/win-library/3.4")
> install.packages("ggplot2")
> install.packages("ggiraph")

> library(Lahman)
> library(dplyr)
> library(ggplot2)
> library(ggiraph)

Lahman database queries and results:

> df<-Batting%>%
+   group_by(playerID)%>%
+   summarize(career_HR=sum(HR),career_SO=sum(SO))%>%
+   filter(career_HR>=400)
> df
# A tibble: 55 x 3
    playerID career_HR career_SO
       <chr>     <int>     <int>
 1 aaronha01       755      1383
 2 bagweje01       449      1558
 3 bankser01       512      1236
 4 beltrad01       445      1584
 5 beltrca01       421      1693
 6 bondsba01       762      1539
 7 cabremi01       446      1516
 8 cansejo01       462      1942
 9 dawsoan01       438      1509
10 delgaca01       473      1745
# ... with 45 more rows
> colnames(Master)
 [1] "playerID"     "birthYear"    "birthMonth"   "birthDay"     "birthCountry" "birthState"   "birthCity"   
 [8] "deathYear"    "deathMonth"   "deathDay"     "deathCountry" "deathState"   "deathCity"    "nameFirst"   
[15] "nameLast"     "nameGiven"    "weight"       "height"       "bats"         "throws"       "debut"       
[22] "finalGame"    "retroID"      "bbrefID"      "deathDate"    "birthDate"   
> inner_join(df,Master,by=c("playerID"))%>%
+   select(nameFirst, nameLast,career_HR,career_SO)
# A tibble: 55 x 4
   nameFirst nameLast career_HR career_SO
       <chr>    <chr>     <int>     <int>
 1      Hank    Aaron       755      1383
 2      Jeff  Bagwell       449      1558
 3     Ernie    Banks       512      1236
 4    Adrian   Beltre       445      1584
 5    Carlos  Beltran       421      1693
 6     Barry    Bonds       762      1539
 7    Miguel  Cabrera       446      1516
 8      Jose  Canseco       462      1942
 9     Andre   Dawson       438      1509
10    Carlos  Delgado       473      1745
# ... with 45 more rows
> HR_vs_SO<-inner_join(df,Master,by=c("playerID"))%>%
+   select(nameFirst, nameLast,career_HR,career_SO)
> ggplot()+
+   geom_point(data=HR_vs_SO,aes(x=career_SO,y=career_HR))
> > g<-ggplot()+
+   geom_point_interactive(data=HR_vs_SO,aes(x=career_SO,y=career_HR,tooltip=nameLast))+
+   ggtitle("Career Homeruns vs. Strikeouts for Great Hitters")+
+   xlab("Career Strikeouts")+
+   ylab("Career Homeruns")
> 
> ggiraph(code=print(g))
> paste(HR_vs_SO$nameFirst,HR_vs_SO$nameLast)
 [1] "Hank Aaron"        "Jeff Bagwell"      "Ernie Banks"       "Adrian Beltre"    
 [5] "Carlos Beltran"    "Barry Bonds"       "Miguel Cabrera"    "Jose Canseco"     
 [9] "Andre Dawson"      "Carlos Delgado"    "Adam Dunn"         "Darrell Evans"    
[13] "Jimmie Foxx"       "Lou Gehrig"        "Jason Giambi"      "Juan Gonzalez"    
[17] "Ken Griffey"       "Vladimir Guerrero" "Reggie Jackson"    "Andruw Jones"     
[21] "Chipper Jones"     "Harmon Killebrew"  "Dave Kingman"      "Paul Konerko"     
[25] "Mickey Mantle"     "Eddie Mathews"     "Willie Mays"       "Willie McCovey"   
[29] "Fred McGriff"      "Mark McGwire"      "Eddie Murray"      "Stan Musial"      
[33] "David Ortiz"       "Mel Ott"           "Rafael Palmeiro"   "Mike Piazza"      
[37] "Albert Pujols"     "Manny Ramirez"     "Cal Ripken"        "Frank Robinson"   
[41] "Alex Rodriguez"    "Babe Ruth"         "Mike Schmidt"      "Gary Sheffield"   
[45] "Duke Snider"       "Alfonso Soriano"   "Sammy Sosa"        "Willie Stargell"  
[49] "Mark Teixeira"     "Frank Thomas"      "Jim Thome"         "Billy Williams"   
[53] "Ted Williams"      "Dave Winfield"     "Carl Yastrzemski" 
> HR_vs_SO$name<-paste(HR_vs_SO$nameFirst,HR_vs_SO$nameLast)
> HR_vs_SO
# A tibble: 55 x 5
   nameFirst nameLast career_HR career_SO           name
       <chr>    <chr>     <int>     <int>          <chr>
 1      Hank    Aaron       755      1383     Hank Aaron
 2      Jeff  Bagwell       449      1558   Jeff Bagwell
 3     Ernie    Banks       512      1236    Ernie Banks
 4    Adrian   Beltre       445      1584  Adrian Beltre
 5    Carlos  Beltran       421      1693 Carlos Beltran
 6     Barry    Bonds       762      1539    Barry Bonds
 7    Miguel  Cabrera       446      1516 Miguel Cabrera
 8      Jose  Canseco       462      1942   Jose Canseco
 9     Andre   Dawson       438      1509   Andre Dawson
10    Carlos  Delgado       473      1745 Carlos Delgado
# ... with 45 more rows
> g<-ggplot()+
+   geom_point_interactive(data=HR_vs_SO,aes(x=career_SO,y=career_HR,tooltip=name))+
+   ggtitle("Career Homeruns vs. Strikeouts for Great Hitters")+
+   xlab("Career Strikeouts")+
+   ylab("Career Homeruns")
> ggiraph(code=print(g))
> g<-ggplot()+
+   geom_point_interactive(data=HR_vs_SO,aes(x=career_SO,y=career_HR,tooltip=name,data_id=nameLast))+
+   ggtitle("Career Homeruns vs. Strikeouts for Great Hitters")+
+   xlab("Career Strikeouts")+
+   ylab("Career Homeruns")
> ggiraph(code=print(g),hover_css="fill:white;stroke:black")
