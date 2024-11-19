T = table(out.ScopeData_controleDiscreto.time, out.ScopeData_controleDiscreto.signals.values)
writetable(T, 'dados_simulink.csv')