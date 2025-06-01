'use client';

import { useEffect, useRef } from 'react';

interface FeatureProps {
  icon: React.ReactNode;
  title: string;
  description: string;
}

const Feature = ({ icon, title, description }: FeatureProps) => {
  return (
    <div className="p-6 rounded-2xl bg-white dark:bg-dark shadow-soft hover:shadow-hover transition-all duration-300 transform hover:-translate-y-1 border border-gray-100 dark:border-gray-800">
      <div className="mb-4 text-primary dark:text-accent">{icon}</div>
      <h3 className="text-lg font-semibold mb-2">{title}</h3>
      <p className="text-gray-600 dark:text-gray-300 text-sm">{description}</p>
    </div>
  );
};

export default function Features() {
  const featuresRef = useRef<HTMLDivElement>(null);
  
  useEffect(() => {
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add('opacity-100', 'translate-y-0');
          }
        });
      },
      { threshold: 0.1 }
    );
    
    const features = featuresRef.current?.querySelectorAll('.feature-item');
    features?.forEach((feature, index) => {
      (feature as HTMLElement).style.transitionDelay = `${index * 150}ms`;
      observer.observe(feature);
    });
    
    return () => {
      features?.forEach((feature) => {
        observer.unobserve(feature);
      });
    };
  }, []);
  
  return (
    <div className="py-12 animated-bg">
      <div className="container mx-auto px-4">
        <h2 className="text-2xl md:text-3xl font-bold text-center mb-8">
          Pourquoi utiliser notre convertisseur ?
        </h2>
        
        <div 
          ref={featuresRef}
          className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6"
        >
          <div className="feature-item opacity-0 translate-y-8 transition-all duration-500">
            <Feature
              icon={
                <svg className="h-10 w-10" fill="currentColor" viewBox="0 0 20 20">
                  <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
                </svg>
              }
              title="Gratuit"
              description="Accès complet à toutes les fonctionnalités de conversion sans frais cachés."
            />
          </div>
          
          <div className="feature-item opacity-0 translate-y-8 transition-all duration-500">
            <Feature
              icon={
                <svg className="h-10 w-10" fill="currentColor" viewBox="0 0 20 20">
                  <path fillRule="evenodd" d="M11.3 1.046A1 1 0 0112 2v5h4a1 1 0 01.82 1.573l-7 10A1 1 0 018 18v-5H4a1 1 0 01-.82-1.573l7-10a1 1 0 011.12-.38z" clipRule="evenodd" />
                </svg>
              }
              title="Rapide"
              description="Conversion instantanée côté client sans attente de téléchargement serveur."
            />
          </div>
          
          <div className="feature-item opacity-0 translate-y-8 transition-all duration-500">
            <Feature
              icon={
                <svg className="h-10 w-10" fill="currentColor" viewBox="0 0 20 20">
                  <path d="M7 3a1 1 0 000 2h6a1 1 0 100-2H7zM4 7a1 1 0 011-1h10a1 1 0 110 2H5a1 1 0 01-1-1zM2 11a2 2 0 012-2h12a2 2 0 012 2v4a2 2 0 01-2 2H4a2 2 0 01-2-2v-4z" />
                </svg>
              }
              title="Multi-formats"
              description="Support de nombreux formats d'images et vidéos pour tous vos besoins."
            />
          </div>
          
          <div className="feature-item opacity-0 translate-y-8 transition-all duration-500">
            <Feature
              icon={
                <svg className="h-10 w-10" fill="currentColor" viewBox="0 0 20 20">
                  <path fillRule="evenodd" d="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
                </svg>
              }
              title="Sécurisé"
              description="Traitement 100% local dans votre navigateur, sans envoi de vos fichiers."
            />
          </div>
        </div>
      </div>
    </div>
  );
} 