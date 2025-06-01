import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";
import ThemeToggle from '../components/ThemeToggle'

const inter = Inter({ 
  subsets: ['latin'],
  variable: '--font-inter',
  display: 'swap'
});

export const metadata: Metadata = {
  title: "Convertisseur de fichiers | Amaury Meiller",
  description: "Application web permettant de convertir des fichiers images et vidéos entre différents formats",
  keywords: 'convertisseur, image, vidéo, jpg, png, webp, mp4, conversion, fichier',
  authors: [{ name: 'Amaury Meiller', url: 'https://meillerweb.fr' }],
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="fr" className="scroll-smooth">
      <body className={`${inter.className} ${inter.variable}`}>
        <div className="min-h-screen flex flex-col">
          <header className="sticky top-0 z-50 backdrop-blur-md bg-white/90 dark:bg-dark/90 border-b border-gray-200 dark:border-gray-800 transition-colors duration-300 shadow-sm">
            <div className="container mx-auto px-4 h-16 flex justify-between items-center">
              <a href="/" className="text-2xl font-bold text-primary tracking-tight flex items-center group">
                <span className="mr-2 text-3xl group-hover:rotate-12 transition-transform duration-300">🔄</span>
                <span className="bg-clip-text text-transparent bg-gradient-to-r from-primary to-secondary">
                  Convertisseur
                </span>
              </a>
              <nav className="flex items-center space-x-6">
                <ThemeToggle />
                <a 
                  href="https://meillerweb.fr" 
                  target="_blank" 
                  rel="noopener noreferrer"
                  className="text-sm hover:text-primary transition-colors flex items-center group"
                >
                  <span className="relative">
                    Portfolio
                    <span className="absolute -bottom-1 left-0 w-0 h-0.5 bg-primary group-hover:w-full transition-all duration-300"></span>
                  </span>
                  <svg 
                    className="ml-1 w-3.5 h-3.5 group-hover:translate-x-1 transition-transform duration-300" 
                    fill="none" 
                    stroke="currentColor" 
                    viewBox="0 0 24 24"
                  >
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M14 5l7 7m0 0l-7 7m7-7H3" />
                  </svg>
                </a>
              </nav>
            </div>
          </header>
          <main className="flex-grow">
            {children}
          </main>
          <footer className="border-t border-gray-200 dark:border-gray-800 py-8 bg-gray-50 dark:bg-gray-900/30">
            <div className="container mx-auto px-4">
              <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div>
                  <h3 className="text-lg font-semibold mb-3">Convertisseur</h3>
                  <p className="text-sm text-gray-600 dark:text-gray-300 mb-4">
                    Solution simple, rapide et sécurisée pour convertir vos fichiers images et vidéos.
                  </p>
                  <div className="flex items-center space-x-4">
                    <a 
                      href="https://github.com/amaurymeiller" 
                      target="_blank" 
                      rel="noopener noreferrer"
                      className="text-gray-500 hover:text-primary transition-colors"
                      aria-label="GitHub"
                    >
                      <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                        <path fillRule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z" clipRule="evenodd" />
                      </svg>
                    </a>
                    <a 
                      href="https://meillerweb.fr" 
                      target="_blank" 
                      rel="noopener noreferrer"
                      className="text-gray-500 hover:text-primary transition-colors"
                      aria-label="Portfolio"
                    >
                      <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                        <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 17.93c-3.95-.49-7-3.85-7-7.93 0-.62.08-1.21.21-1.79L9 15v1c0 1.1.9 2 2 2v1.93zm6.9-2.54c-.26-.81-1-1.39-1.9-1.39h-1v-3c0-.55-.45-1-1-1H8v-2h2c.55 0 1-.45 1-1V7h2c1.1 0 2-.9 2-2v-.41c2.93 1.19 5 4.06 5 7.41 0 2.08-.8 3.97-2.1 5.39z" />
                      </svg>
                    </a>
                  </div>
                </div>
                
                <div>
                  <h3 className="text-lg font-semibold mb-3">Liens rapides</h3>
                  <ul className="space-y-2 text-sm">
                    <li>
                      <a href="#converter" className="text-gray-600 dark:text-gray-300 hover:text-primary transition-colors">
                        Convertisseur
                      </a>
                    </li>
                    <li>
                      <a href="#features" className="text-gray-600 dark:text-gray-300 hover:text-primary transition-colors">
                        Caractéristiques
                      </a>
                    </li>
                    <li>
                      <a 
                        href="https://github.com/Amolyy25" 
                        target="_blank" 
                        rel="noopener noreferrer"
                        className="text-gray-600 dark:text-gray-300 hover:text-primary transition-colors"
                      >
                        Projet GitHub
                      </a>
                    </li>
                  </ul>
                </div>
                
                <div>
                  <h3 className="text-lg font-semibold mb-3">À propos</h3>
                  <p className="text-sm text-gray-600 dark:text-gray-300 mb-4">
                    Projet développé par Amaury Meiller. Application open source.
                  </p>
                  <a 
                    href="https://meillerweb.fr" 
                    target="_blank" 
                    rel="noopener noreferrer" 
                    className="inline-flex items-center text-primary hover:underline"
                  >
                    Découvrir mon portfolio
                    <svg className="ml-1 w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M14 5l7 7m0 0l-7 7m7-7H3" />
                    </svg>
                  </a>
                </div>
              </div>
              
              <div className="mt-8 pt-6 border-t border-gray-200 dark:border-gray-800 text-center">
                <p className="text-sm text-gray-500">
                  © {new Date().getFullYear()} - Développé par <a href="https://meillerweb.fr" target="_blank" rel="noopener noreferrer" className="text-primary hover:underline">Amaury Meiller</a>
                </p>
              </div>
            </div>
          </footer>
        </div>
      </body>
    </html>
  );
}
