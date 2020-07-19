function format_figure(tLab, xLab, yLab, zLab)
  set(gca, 'Title', tLab)
  set(gca, 'xlabel', xLab)
  set(gca, 'ylabel', yLab)
  if nargin==4
    set(gca, 'zlabel', zLab)  
  end
  grid on;
  box on;
endfunction
