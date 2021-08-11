fileConn<-file("/test_mosaic/G2/newtest.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)