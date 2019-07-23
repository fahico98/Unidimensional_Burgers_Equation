
clear; % Se eliminan todas las variables almacenadas en el Workspace.
clc; % Se limpia la ventana de comandos.

%% 1. Declaracion de las variables que se van a utilizar en el analisis.

dx = 0.01;                  % Tamaño de paso para x.
dt = 0.00001;               % Tamaño de paso para t.

tMin = 0;                   % Valor minimo de t.
tMax = 1;                   % Valor maximo de t.

xMin = 0;                   % Valor minimo de x.
xMax = 1;                   % Valor maximo de x.

v = 1;                      % Velocidad cinematica.

x = xMin : dx : xMax;       % Vector de valores de x.
t = tMin : dt : tMax;       % Vector de valores de t.
 
u_0 = sin(pi.*x);   % Vector de valores iniciales para el istante t = 0
                    % definidos en el intervalo 0 < x < 1.

u_0(length(u_0)) = 0;   % Se establece como 0 el valor del ultimo elemento
                        % del vector u_0 segun las condiciones iniciales
                        % del problema propuesto, u(0,t) = u(1,t) = 0.
                        
u = zeros(length(t), length(x));    % Definicion de la matriz u que
                                    % contredra los resultados calculados
                                    % de forma numerica.
                      
u(1,:) = u_0;   % Se establece como primera final de la matriz u los al
                % vector de valores iniciales u_0.
                
%% 2. Algoritmo para generar los valores aproximados de u.

for n = 1 : length(t) - 1   % Se inician las iteraciones para el vector t
                            % por medio de la variable de iteracion n, no
                            % se itera sobre el ultimo valor del vector ya
                            % que este sera calculado cuando el bucle
                            % recorra la penultima fila de la matriz u.
                            
    for i = 2 : length(x) - 1   % Se inician las iteraciones para el vector
                                % x por medio de la variable i, no se itera
                                % sobre el primer ni sobre el ultimo valor
                                % del vector ya que estos valores estan
                                % definidos en las condiciones iniciales
                                % del problema y solamente se hara ferencia
                                % a ellos para extraer sus datos y no para
                                % sobreescribirlos.
                                
        term1 = v * (dt/(dx^2)) * (u(n,i+1) - 2*u(n,i) + u(n,i-1));
        % Primer termino de la ecuacion de diferencias finitas.
        
        term2 = u(n,i) * (dt/dx) * (u(n,i) - u(n,i-1));
        % Segundo termino de la ecuacion de diferencias finitas.
        
        u(n+1,i) = term1 - term2 + u(n,i);  % Se calcula el valor de u en
                                            % un paso de tiempo hacia
                                            % adelante.
    end
end

% Mostrar resultados.
% s = surf(u);
% s.EdgeColor = "none";

%% 3. Algoritmo para generar las curvas de u en 3D para diferentes instantes de tiempo.

totalLines = 25; % Numero de curvas por grafico
index = 1;
sumIndex = (length(t) - 1) / totalLines;

plotIndex = 1;
plotMatrix = zeros(length(x), totalLines + 1);

for tIndex = 1 : length(t)
    if tIndex == index
        plotMatrix(:, plotIndex) = u(tIndex, :);
        plotIndex = plotIndex + 1;
        index = index + sumIndex;
    end
end

xMat = repmat(x', 1, totalLines + 1);
dy = dt * sumIndex;
yMat = repmat(0:dy:1, numel(x), 1);

plot3(xMat, yMat, plotMatrix, "r");
grid on;
xlabel("x");
ylabel("t");
zlabel("u");

%% 4. Algoritmo para generar los datos de la funcion u de forma analitica.

% a_n_function(n, v, lowerBound, upperBound): funcion que retorna el valor
% de a_n.

% a_0_function(v, lowerBound, upperBound): funcion que retorna el valor de
% a_0.

% uNumerator(t, x, v): funcion que retorna el valor del numerador de la
% funcion u analitica.

% uDenominator(t, x, v, a_0): funcion que retorna el valor del denominador
% de la funcion u analitica.

uAnalitica = zeros(length(t), length(x));
a_0 = a_0_function(v, 0, 1);

for i = 1 : length(t)
    for j = 1 : length(x)
        num = uNumerator(t(i), x(j), v);
        den = uDenominator(t(i), x(j), v, a_0);
        uAnalitica(i, j) = num / den;
    end
end
