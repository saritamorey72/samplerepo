fileConn<-file("/notebooks/notebooks/QAfile.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)