# Normierungsfaktoren 
def Klm(l,m):
    if (m<0):
        return Klm(l,-m)
    return sqrt( (2*l+1)/(2*pi) * factorial(l-m)/factorial(l+m))
#
# assoziierte Legendrepolynomen
def P_shift(l,m,x):
    return gen_legendre_P( l,m,(2*x-1))
#
# Die Basisfunktionen 
#
def hsh(l,m,x,y):
    if m == 0:
        return Klm(l,0)*P_shift(l,m,cos(x))
    if m < 0: 
        return sqrt(2)*Klm(l,-m)*P_shift(l,-m,cos(x))*sin(-m*y) 
    if m > 0:
        return sqrt(2)*Klm(l,m)*P_shift(l,m,cos(x))*cos(m*y)
#
var("theta,phi,l,m")
#
#
# Anmerkung: 
#  * srange statt range, sonst hat gen_legendre_P ein Problem
#  * siehe https://ask.sagemath.org/question/8131/attributeerror-int-object-has-no-attribute-mod/
# statt über die for-loops 
# for l in srange(0,5):
#    for m in srange(-l,l+1): 
# zur Erzeugung aller Basisfunktionen, hier jetzt ein "interact" zur 
# Auswahl der Parameter von l und m, für m muss -l <= m <= l gelten.
# 
@interact
def data(l=(4,srange(4,5)), m=(2,srange(-4,5))):
        Y=hsh(l,m,theta,phi)
        rea = spherical_plot3d( max_symbolic(Y,0.0), (phi,0,2*pi), (theta,0.0,pi/2), 
                                color='blue', plot_points=(80,80), opacity=0.9)
        ima = spherical_plot3d( abs(min_symbolic(Y,0.0)), (phi,0,2*pi), (theta,0.0,pi/2), 
                                color='green', plot_points=(80,80), opacity=0.9)
        (rea+ima).show(aspect_ratio=1)
