clc;
clear;
close all;

CostFunction= @(x)Fonksiyon(x);
NormFunction=@(x)Normalize(x);
%Normal=@(x)Fonksiyon(x);
nVar=4;
VarSize=[1 nVar];
VarMin=[0 0 0.5 400];
VarMax=[15 15 0.6 500];



MaxIt=300;
nPop=50;%first popülasyon_size
w=1;
c1=2;
c2=2;
%Initilization

empty_particle.Velocity=[];
empty_particle.Position=[];
empty_particle.Cost=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];
empty_particle.Norm=[];
empty_particle.NormReg=[];

particle=repmat(empty_particle,nPop,1);
GlobalBest.Cost=inf;

%en iyi normalizasyon%
for i=1:nPop
   
     particle(i).Position=unifrnd(VarMin,VarMax,VarSize); 
     %for j=1:length(VarMin)
       
      % particle(i).Position(j)=(particle(i).Position(j)-VarMin(j))/((VarMax(j)-VarMin(j)));
        
     %end
     %normalizasyon
     particle(i).Norm=NormFunction(particle(i).Position);
    particle(i).Velocity=zeros(VarSize);
%%%---Hata  
particle(i).Cost=CostFunction(particle(i).Position);
%%normalizasyon için regerrasyon
particle(i).NormReg=CostFunction(particle(i).Norm);
%update
 
  particle(i).Best.Position=particle(i).Position;
  particle(i).Best.Cost=particle(i).Cost;
  %gbest
  if particle(i).Best.Cost<GlobalBest.Cost
  GlobalBest=particle(i).Best;
  end
   
         %else 
           %  i=i-1;
    
 
end
%Iteration for best
BestCosts=zeros(MaxIt,1);

% Main (Iterations)
for it=1:MaxIt
    for i=1:nPop
        syc=0;
        a=0;
           
        particle(i).Velocity=particle(i).Velocity+c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position)+c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position); 
         a=(particle(i).Position+particle(i).Velocity);
       for j=1:length(VarMin)
       
            if(VarMin(j)<a(j))&&(VarMax(j)>a(j))
      
        particle(i).Position(j)=(particle(i).Position(j)+particle(i).Velocity(j));
      
            else
                
                syc=1;
            end
           
       end
       if syc==0
        
       % particle(i).Position=particle(i).Position+particle(i).Velocity;
      % particle(i).Position=normalize(particle(i).Position);
       particle(i).Norm=NormFunction(particle(i).Position);
       particle(i).NormReg=CostFunction(particle(i).Norm);
        particle(i).Cost=CostFunction(particle(i).Position);
        if particle(i).Cost<particle(i).Best.Cost
            particle(i).Best.Position=particle(i).Position;
            particle(i).Best.Cost=particle(i).Cost;
            if particle(i).Best.Cost<GlobalBest.Cost
            GlobalBest=particle(i).Best;
               end
        
        end
        
       else
           i=i-1;
       end
    BestCosts(it)=GlobalBest.Cost;
 
    disp(['iterasyon=' num2str(it):'En Ýyi Sonuc=' num2str(BestCosts(it))]);
    
end
end
%Results
figure;
plot(BestCosts,'LineWidth',2);
xlabel('Iterasyon');
ylabel('En Ýyi');


