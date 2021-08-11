fileConn<-file("/test_mosaic/G3/newtest.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)