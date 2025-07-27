%% mu_a calculation

function [mu_a, mu_a_s, mu_a_d] = mu_a_calculation(hbt, oxy_sim_all)
    excoef = [710 1058; 1075.44 691.32]; %[780 850], source: https://omlc.org/spectra/hemoglobin/summary.html
    excoef = excoef * 2.303/1000;
    
    hbo = oxy_sim_all*hbt;
    hb = (1-oxy_sim_all) *hbt;
    conc = [hbo;hb];
    mu_a = (conc' * excoef')'/10; %[780; 850]
    offset = 0.3*hbt;
    
    hbt_dia = hbt-offset;
    hbt_sys = hbt+offset;
    hbo_s = oxy_sim_all*hbt_sys;
    hb_s = (1-oxy_sim_all) *hbt_sys;
    conc_s = [hbo_s;hb_s];
    mu_a_s = (conc_s' * excoef')'/10; %[780; 850]
    
    hbo_d = oxy_sim_all*hbt_dia;
    hb_d = (1-oxy_sim_all) *hbt_dia;
    conc_d = [hbo_d;hb_d];
    mu_a_d = (conc_d' * excoef')'/10; %[780; 850]
end