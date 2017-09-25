df<-Teams%>%
  filter(yearID==1980)%>%
  select(name,HR)%>%
  arrange(HR)

df$name<-factor(df$name,levels=df$name)

ggplot()+
  geom_bar(data=df,aes(x=name,y=HR),stat="identity", color="blue", fill="white")+
  coord_flip()
  