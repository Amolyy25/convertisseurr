'use client';

import { useState, useEffect } from 'react';
import Image from 'next/image';

interface ConversionResultProps {
  convertedFile: string | null;
  error: string | null;
  fileName: string | undefined;
  targetFormat: string;
}

const ConversionResult = ({
  convertedFile,
  error,
  fileName,
  targetFormat,
}: ConversionResultProps) => {
  const [copied, setCopied] = useState(false);
  const [downloaded, setDownloaded] = useState(false);
  const [animate, setAnimate] = useState(false);

  useEffect(() => {
    // Animation d'entrée
    if (convertedFile || error) {
      setTimeout(() => {
        setAnimate(true);
      }, 100);
    }
  }, [convertedFile, error]);

  const handleDownload = () => {
    if (convertedFile) {
      const link = document.createElement('a');
      link.href = convertedFile;
      const newFileName = fileName
        ? `${fileName.split('.').slice(0, -1).join('.')}.${targetFormat}`
        : `converted.${targetFormat}`;
      link.download = newFileName;
      link.click();
      
      // Animation pour l'effet de téléchargement
      setDownloaded(true);
      setTimeout(() => setDownloaded(false), 2000);
    }
  };

  const handleCopy = () => {
    if (convertedFile) {
      navigator.clipboard.writeText(convertedFile).then(() => {
        setCopied(true);
        setTimeout(() => setCopied(false), 2000);
      });
    }
  };

  if (error) {
    return (
      <div className={`p-6 bg-red-50 dark:bg-red-900/20 border border-red-300 dark:border-red-900 text-red-700 dark:text-red-300 rounded-2xl transition-all duration-500 ${animate ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'}`}>
        <div className="flex items-start">
          <div className="flex-shrink-0">
            <svg className="h-6 w-6 text-red-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
            </svg>
          </div>
          <div className="ml-3">
            <h3 className="text-lg font-semibold mb-2">Erreur de conversion</h3>
            <p className="text-sm">{error}</p>
            <div className="mt-4">
              <button 
                onClick={() => window.location.reload()} 
                className="text-sm px-3 py-1.5 bg-red-100 dark:bg-red-900/30 hover:bg-red-200 dark:hover:bg-red-800/40 text-red-700 dark:text-red-300 rounded-lg transition-colors"
              >
                Réessayer
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  if (!convertedFile) return null;

  const isImage = fileName?.match(/\.(jpg|jpeg|png|gif|webp|svg|heic)$/i);
  const isVideo = fileName?.match(/\.(mp4|mov|avi|webm|mkv)$/i);
  const newFileName = fileName
    ? `${fileName.split('.').slice(0, -1).join('.')}.${targetFormat}`
    : `converted.${targetFormat}`;

  return (
    <div className={`transition-all duration-700 ${animate ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-8'}`}>
      <div className="flex justify-between items-center mb-6">
        <h3 className="text-xl font-semibold flex items-center">
          <svg className="h-5 w-5 mr-2 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
          </svg>
          Conversion réussie
        </h3>
        <span className="text-xs text-gray-500 px-2 py-1 bg-gray-100 dark:bg-gray-800 rounded-full">
          {targetFormat.toUpperCase()}
        </span>
      </div>
      
      <div className="grid md:grid-cols-2 gap-8">
        <div className="relative rounded-2xl overflow-hidden bg-gray-100 dark:bg-gray-800/50 border border-gray-200 dark:border-gray-700 h-64 group">
          {isImage ? (
            <Image
              src={convertedFile}
              alt="Fichier converti"
              fill
              className="object-contain transition-transform duration-300 group-hover:scale-105"
              sizes="(max-width: 768px) 100vw, 600px"
            />
          ) : isVideo ? (
            <video
              src={convertedFile}
              controls
              className="w-full h-full object-contain"
            />
          ) : (
            <div className="flex items-center justify-center h-full">
              <div className="text-center">
                <svg className="h-16 w-16 mx-auto text-gray-400 mb-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                </svg>
                <p className="text-gray-500">Aperçu non disponible</p>
              </div>
            </div>
          )}
          
          <div className="absolute bottom-0 inset-x-0 bg-gradient-to-t from-black/70 to-transparent p-4 opacity-0 group-hover:opacity-100 transition-opacity">
            <p className="text-white text-sm">Format d'origine: {fileName?.split('.').pop()?.toUpperCase()}</p>
          </div>
        </div>
        
        <div className="flex flex-col justify-between">
          <div>
            <h4 className="font-medium mb-3 text-lg">Informations</h4>
            <div className="space-y-3">
              <div className="flex items-center p-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl">
                <svg className="h-5 w-5 text-gray-500 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M15.172 7l-6.586 6.586a2 2 0 102.828 2.828l6.414-6.586a4 4 0 00-5.656-5.656l-6.415 6.585a6 6 0 108.486 8.486L20.5 13" />
                </svg>
                <div className="flex-1">
                  <p className="text-xs text-gray-500 mb-0.5">Nom du fichier</p>
                  <p className="font-medium text-sm truncate" title={newFileName}>{newFileName}</p>
                </div>
              </div>
              
              <div className="flex items-center p-3 bg-gray-50 dark:bg-gray-800/50 rounded-xl">
                <svg className="h-5 w-5 text-gray-500 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M4 5a1 1 0 011-1h14a1 1 0 011 1v2a1 1 0 01-1 1H5a1 1 0 01-1-1V5zM4 13a1 1 0 011-1h6a1 1 0 011 1v6a1 1 0 01-1 1H5a1 1 0 01-1-1v-6zM16 13a1 1 0 011-1h2a1 1 0 011 1v6a1 1 0 01-1 1h-2a1 1 0 01-1-1v-6z" />
                </svg>
                <div className="flex-1">
                  <p className="text-xs text-gray-500 mb-0.5">Format</p>
                  <p className="font-medium text-sm">{targetFormat.toUpperCase()}</p>
                </div>
              </div>
            </div>
          </div>
          
          <div className="space-y-3 mt-6">
            <button
              onClick={handleDownload}
              className={`btn btn-primary w-full flex items-center justify-center ${downloaded ? 'bg-green-500' : ''}`}
            >
              {downloaded ? (
                <>
                  <svg className="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                  </svg>
                  Téléchargé !
                </>
              ) : (
                <>
                  <svg 
                    className="w-5 h-5 mr-2 transition-transform group-hover:translate-y-1" 
                    fill="none" 
                    stroke="currentColor" 
                    viewBox="0 0 24 24"
                  >
                    <path 
                      strokeLinecap="round" 
                      strokeLinejoin="round" 
                      strokeWidth={2} 
                      d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" 
                    />
                  </svg>
                  Télécharger
                </>
              )}
            </button>
            
            <button
              onClick={handleCopy}
              className="btn w-full border border-gray-300 dark:border-gray-700 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-700 flex items-center justify-center"
            >
              {copied ? (
                <>
                  <svg className="w-5 h-5 mr-2 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                  </svg>
                  Lien copié !
                </>
              ) : (
                <>
                  <svg className="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M8 16H6a2 2 0 01-2-2V6a2 2 0 012-2h8a2 2 0 012 2v2m-6 12h8a2 2 0 002-2v-8a2 2 0 00-2-2h-8a2 2 0 00-2 2v8a2 2 0 002 2z" />
                  </svg>
                  Copier le lien
                </>
              )}
            </button>
            
            <button
              onClick={() => window.location.reload()}
              className="btn w-full border border-gray-300 dark:border-gray-700 bg-white dark:bg-gray-800 text-gray-700 dark:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-700 flex items-center justify-center"
            >
              <svg className="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
              </svg>
              Convertir un autre fichier
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default ConversionResult; 