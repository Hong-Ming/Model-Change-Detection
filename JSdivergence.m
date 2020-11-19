function JS = JSdivergence(w1,w2,feature)

JS = 0;
P1 = mnrval(w1,feature);
P2 = mnrval(w2,feature);

for u = 1:2
    for v = 1:length(feature)
        p = P1(v,u);
        q = P2(v,u);
        m = (p+q)/2;
        if p ~= 0
            JS = JS + 0.5*p*log(p/m);
        end
        if q ~= 0
            JS = JS + 0.5*q*log(q/m);
        end
    end        
end

end