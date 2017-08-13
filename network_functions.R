library(jsonlite)
library(data.table)
library(networkD3)


get_source_user <- function(name){
  a <- fromJSON(paste('https://webapi.steemdata.com/Accounts?where=name==',name,sep = ""))
  return(data.frame(name=as.character(name), sp=a$`_items`$sp, post_count=a$`_items`$post_coun,
                    following_count = a$`_items`$following_count, followers_count= a$`_items`$following_count, rep=a$`_items`$rep))
}

make_size <- function(x, from, to){
  (x - min(x)) / max(x - min(x)) * (to - from) + from
}


get_network_data <- function(name, type){

adat <- fromJSON(paste('https://api.steemdata.com/busy.org/',name,'/',type, sep = ""))

adat <- rbind(get_source_user(name), adat)
adat$name <- as.character(adat$name)

if(type=='followers'){
  adat$target <- name
  names(adat)[1]<- 'source'
}else if(type=='following'){
  adat$source <- name
  names(adat)[1]<- 'target'
}
return(adat)

}

#get_network_data('misrori', 'following')


get_group_network <- function(my_names, node_size, type){
  my_names <- c('misrori', "cuttie1979")
  node_size <- "sp"
  type <- 'following'
  
  my_df <- data.frame()
  for (i in my_names){
    my_df <- rbind(my_df, get_network_data(i, type))
  }
  
  
  if(type=='followers'){
    
    nevek_list <- data.frame(nevek = unique(c(unique(my_df$source), unique(my_df$target))))
    nevek_list$nevek <- as.character(nevek_list$nevek)
    nevek_list$id <- 0:(nrow(nevek_list)-1)
    
    
    
    nevek_list <- data.table(nevek_list)
    my_df <- data.table(my_df )
    setkey(nevek_list, nevek)
    setkey(my_df, source)
    
    my_df$source_id <- nevek_list[my_df][,id]
    
    setkey(my_df, target)
    
    my_df$target_id <- nevek_list[my_df][,id]
    
    my_links <- my_df[,c(8,9)]
    my_links <- my_links[source_id!=target_id,]
    my_links$value <- 1
    
    setkey(my_df, source)
    setkey(nevek_list, nevek)
    t <- my_df[duplicated(my_df$source)==F,c(1:6)]
    setkey(t,source)
    
    my_nodes <- t[nevek_list]
    
    my_nodes$group <- 1
    my_nodes$my_size <- make_size(my_nodes [,which(colnames(my_nodes)==node_size), with=F], 1,100)
    setorder(my_nodes, id)
    

    
    
   net <- forceNetwork(Links = my_links, Nodes = my_nodes,
                        Source = "source_id", Target = "target_id", zoom = T,
                        Value = "value", NodeID = "source",Nodesize = 'my_size',fontSize = 15,
                        Group = "group", opacity = 1, arrows = T,  bounded = F, opacityNoHover=0.7)
    
    return(net)
    
    
  }
  else if(type=='following'){
    
    nevek_list <- data.frame(nevek = unique(c(unique(my_df$source), unique(my_df$target))))
    nevek_list$nevek <- as.character(nevek_list$nevek)
    nevek_list$id <- 0:(nrow(nevek_list)-1)
    
    
    
    nevek_list <- data.table(nevek_list)
    my_df <- data.table(my_df )
    setkey(nevek_list, nevek)
    setkey(my_df, source)
    
    my_df$source_id <- nevek_list[my_df][,id]
    
    setkey(my_df, target)
    
    my_df$target_id <- nevek_list[my_df][,id]
    
    my_links <- my_df[,c(8,9)]
    my_links <- my_links[source_id!=target_id,]
    my_links$value <- 1
    
    setkey(my_df, target)
    setkey(nevek_list, nevek)
    t <- my_df[duplicated(my_df$target)==F,c(1:6)]
    setkey(t,target)
    
    my_nodes <- t[nevek_list]
    
    my_nodes$group <- 1
    my_nodes$my_size <- make_size(my_nodes [,which(colnames(my_nodes)==node_size), with=F], 1,100)
    setorder(my_nodes, id)
    
    
    
    
    net <- forceNetwork(Links = my_links, Nodes = my_nodes,
                        Source = "source_id", Target = "target_id", zoom = T,
                        Value = "value", NodeID = "target",Nodesize = 'my_size',fontSize = 15,
                        Group = "group", opacity = 1, arrows = T,  bounded = F, opacityNoHover=0.7)
    
    return(net)
    
  }
  
  
  
 
}






