fileConn<-file("/test_mosaic/G2/write.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)