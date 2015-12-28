%initializing the population
function sol_new=initial(n,p);
r=ceil(rand*n);
sol_new(1)=r;
for i=2:p
    r=ceil(rand*n);
    while repeatornot(sol_new(1:i-1),i-1,r)
        r=ceil(rand*n);
    end
    sol_new(i)=r; 
end 