function [out] = rmse(y, y_pred)
out = sqrt(mean((y-y_pred).^2));
end