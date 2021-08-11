fileConn<-file("/test_mosaic/G1/newtest.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)