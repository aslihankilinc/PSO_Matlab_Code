function Norm = Normalize(x)
VarMin=[0 0 0.5 400];
VarMax=[15 15 0.6 500];
Norm = (x - VarMin)./ (VarMax - VarMin)
end

