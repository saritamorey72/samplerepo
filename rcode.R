

fileConn<-file("/data/output12.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)

fileConn<-file("/test_mosaic/G2/output131.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)

fileConn<-file("/test_mosaic/G1/output132.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)

fileConn<-file("/test_mosaic/G3/output132.txt")
writeLines(c("Hello","World"), fileConn)
close(fileConn)


