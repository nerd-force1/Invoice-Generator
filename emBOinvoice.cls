\ProvidesClass{emBOinvoice}

\LoadClass[
    %DIN,
    firsthead = on,
    firstfoot = on,
    nextfoot=on,
    backaddress=on,
    fromemail=true,
    fromurl=true,
    numericaldate=false,
    foldmarks=on,
    subject=off,
    enlargefirstpage=true,
    headings
    ]{scrlttr2}
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%Sprache wehcseln
\newcommand{\deutsch}{
	\newcommand{\PostenT}{Posten}
	\newcommand{\AnzahlT}{Anzahl}
	\newcommand{\EinzelpreisT}{Einzelpreis}
	\newcommand{\GesamtpreisT}{Gesamtpreis}
	\newcommand{\Tabellenkopf}[1][]{
    \begin{minipage}[t]{\textwidth}
        \large \textbf{Rechnung emBO++ #1}
    \end{minipage}
}
	\newcommand{\Rechnungsnr}{Rechnungsnr:~}
	\newcommand{\SummeT}{Summe}
	\newcommand{\MwStT}{MwSt.~}
	\newcommand{\GesamtbetragT}{Gesamtbetrag}
	}
	
\newcommand{\englisch}{
	\newcommand{\PostenT}{Position}
	\newcommand{\AnzahlT}{Amount}
	\newcommand{\EinzelpreisT}{Single}
	\newcommand{\GesamtpreisT}{Total}
	\newcommand{\Tabellenkopf}[1][]{
   		 \begin{minipage}[t]{\textwidth}
    	    		\large \textbf{Invoice emBO++ #1}
    		\end{minipage}
		}
	\newcommand{\Rechnungsnr}{Invoicenumber:~}
	\newcommand{\SummeT}{Sum}
	\newcommand{\MwStT}{VAT~}
	\newcommand{\GesamtbetragT}{Total}
	}
	
\ProcessOptions*\relax
\renewcommand*{\letterpagestyle}{headings}

\RequirePackage{etoolbox}
\RequirePackage[ngerman]{babel}
\RequirePackage[nomessages]{fp}
\RequirePackage{longtable,booktabs}
\RequirePackage[table]{xcolor} 
\definecolor{light-gray}{HTML}{E5E4E2}

\RequirePackage{eurosym}
\RequirePackage{setspace}

\RequirePackage{graphicx}

%%%%%%%%KOMAvariablen

\newkomavar{rechnungsnummer} %enthält die Rechnungsnummer
\newkomavar{empfaenger}		% enthält die Empfängerinformationen
\newkomavar{zahlungsinfo}	% enthält alle wichtigen Zahlungsinformationen, am besten in Form einer Tabelle

\providetoggle{euroWaehrung}

%%%%%%%%%%%%%%Diese Datei enthält alle wichtigen und für das erstellen der Rechnung relevanten Informationen. Existiert sie nicht, kann selbst etwas in der main geschrieben werden%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\IfFileExists{RechnungsDatenInput.tex}{
	\input{RechnungsDatenInput.tex}
	\iftoggle{euroWaehrung}{
		\newcommand{\waehrung}{\,\euro{}}
		}{
			\newcommand{\waehrung}{\,\$ }
		}
	}
	{\newcommand{\waehrung}{\euro{}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%Bilder einfügen mit einfachen Mitteln
\newcommand\bildEinfuegen[2][height=3\baselineskip]{%
    \includegraphics[#1]{#2}
}


%%%%%%%%%%%%%%%%%%%%%%%%%Code, der am Ende und am Anfang des Dokuments ausgeführt werden soll
%%%Start beginnt den Brief mit der Rechnungsnummer
%%%Ende setzt die Unterschrift
\newcommand{\Start}{
    \opening{
    		\large \Rechnungsnr \usekomavar{rechnungsnummer}
    		}
	}
\newcommand{\Ende}{
    \vspace{\baselineskip}
    \usekomavar{signature}
    \vfill{}
	}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Setzen von Head und foot///Logo etc.
\setkomavar{firsthead}{
    \begin{minipage}[t][][t]{0.7\textwidth}
        \vspace{0.5\baselineskip}
        \usekomavar{fromlogo}
    \end{minipage}
     \begin{minipage}[t][][t]{0.3\textwidth}
        \raggedleft
        \vspace{0.5\baselineskip}
        \usekomavar{fromname}
        \usekomavar{fromname2}
        \usekomavar{fromaddress}\\
        \vspace{0.5\baselineskip}
        \usekomavar{fromemail}\\
        \usekomavar{fromurl}\\
    \end{minipage}
}

\setkomavar{nexthead}{}
\@setplength{firstfootvpos}{0.9\paperheight}
\setkomavar{firstfoot}{
    \usekomavar{zahlungsinfo}
}

\setkomavar{nextfoot}{
    \usekomavar{zahlungsinfo}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tatsäcliche Rechnungsumgebung
\newenvironment{Rechnung}{%begin
    %Definiere notwendige Befehle
    \FPset\Gesamtsumme{0.00}
    \newcounter{zeile}
    
    \newcommand{\rechnungsbetrag}[2]{%
        \FPmul\result{##1}{##2}
        \FPround\result{\result}{2}
        \FPadd\0\Gesamtsumme{\result}\global\let\Gesamtsumme\0
        \FPprint{\result \waehrung}
   }
   \newcommand{\GesamtsummeDarstellen}{
       \FPround\Gesamtsumme{\Gesamtsumme}{2}
       \FPprint{\Gesamtsumme \waehrung}
   }
   \newcommand{\mehrwersteuer}{
        \FPmul\result{\Gesamtsumme}{0.19}
        \FPround\result{\result}{2}
        \FPadd\0\Gesamtsumme{\result}\global\let\Gesamtsumme\0
        \FPprint{\result \waehrung}
   }

   \newcommand{\Posten}[3]{%
        \stepcounter{zeile} \thezeile  & ##1& ##2& ##3\waehrung & \rechnungsbetrag{##2}{##3}\\ 
    }
    
    \newcommand{\Discount}[3]{%
        \stepcounter{zeile} \thezeile  & ##1& ##2& -##3\waehrung & \rechnungsbetrag{##2}{-##3}\\
    }
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Die Rechnungstabelle erzeugen
        \rowcolors{1}{white}{light-gray}
        \begin{longtable}[h!]{lp{0.3\textwidth}rrr}
        \hiderowcolors
            \toprule
             & \textbf{\PostenT}    & \textbf{\AnzahlT}    &\textbf{\EinzelpreisT \waehrung}    &\textbf{\GesamtpreisT \waehrung}\\
        \showrowcolors
        }{%end
        \hiderowcolors
            \bottomrule
            \multicolumn{4}{l}{\SummeT}   & \GesamtsummeDarstellen \\
            \multicolumn{4}{l}{\MwStT 19\%} & \mehrwersteuer \\ 
            \bottomrule
            \bottomrule
            \multicolumn{4}{l}{\GesamtbetragT}   & \GesamtsummeDarstellen\\
        \end{longtable}
    }