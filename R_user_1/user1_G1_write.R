fileConn<-file("/test_mosaic/G3/writeG1.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)