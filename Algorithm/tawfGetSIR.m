function sir = tawfGetSIR(x,y,x_hat)

sir = var(y-x)/var(x_hat-x);

end