fileConn<-file("/test_mosaic/G1/write.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)