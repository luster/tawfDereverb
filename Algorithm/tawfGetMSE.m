function mse = tawfGetMSE(x,x_hat)

mse = mean((x-x_hat).^2);

end