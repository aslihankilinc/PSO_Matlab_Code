function Norm = Normalize(x)
VarMin=[0 0 0.5 400];
VarMax=[15 15 0.6 500];
Norm = (x - VarMin)./ (VarMax - VarMin)
%your_original_data = minVal + norm_data. * (maxVal - minVal)
end

