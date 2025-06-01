'use client';

import { useState } from 'react';
import Image from 'next/image';
import FileUploader from '../components/FileUploader';
import ConversionOptions from '../components/ConversionOptions';
import ConversionResult from '../components/ConversionResult';
import Hero from '../components/Hero';
import Features from '../components/Features';
import { FileWithPreview } from '../lib/types';
import { convertFile } from '../lib/ffmpegUtils';

export default function Home() {
  const [file, setFile] = useState<FileWithPreview | null>(null);
  const [convertedFile, setConvertedFile] = useState<string | null>(null);
  const [targetFormat, setTargetFormat] = useState<string>('');
  const [isConverting, setIsConverting] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);

  const handleFileChange = (newFile: FileWithPreview | null) => {
    setFile(newFile);
    setConvertedFile(null);
    setError(null);
    
    // Réinitialiser le format cible en fonction du type de fichier
    if (newFile) {
      const fileType = newFile.type.split('/')[0];
      if (fileType === 'image') {
        setTargetFormat('jpg');
      } else if (fileType === 'video') {
        setTargetFormat('mp4');
      }
    } else {
      setTargetFormat('');
    }
  };

  const handleFormatChange = (format: string) => {
    setTargetFormat(format);
    setConvertedFile(null);
    setError(null);
  };

  const handleConversion = async () => {
    if (!file || !targetFormat) return;

    setIsConverting(true);
    setError(null);
    
    try {
      // Appel à la fonction de conversion
      const result = await convertFile(file, targetFormat as any);
      setConvertedFile(result);
    } catch (err: any) {
      setError(err.message || 'Une erreur est survenue lors de la conversion');
      console.error(err);
    } finally {
      setIsConverting(false);
    }
  };

  return (
    <div className="animated-bg">
      <Hero />
      
      <div id="converter" className="py-12">
        <div className="max-w-6xl mx-auto px-4">
          <div className="text-center mb-12">
            <h2 className="text-3xl font-bold mb-3">Convertisseur de fichiers</h2>
            <p className="text-gray-600 dark:text-gray-300 max-w-2xl mx-auto">
              Convertissez facilement vos images et vidéos entre différents formats avec notre outil simple et intuitif
            </p>
          </div>

          <div className="grid md:grid-cols-2 gap-8">
            <div className="card transform transition-all duration-500 hover:-translate-y-1 hover:shadow-hover">
              <h2 className="text-xl font-semibold mb-6 flex items-center">
                <svg className="h-6 w-6 mr-2 text-primary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                </svg>
                Fichier source
              </h2>
              <FileUploader onFileChange={handleFileChange} file={file} />
            </div>

            <div className="card transform transition-all duration-500 hover:-translate-y-1 hover:shadow-hover">
              <h2 className="text-xl font-semibold mb-6 flex items-center">
                <svg className="h-6 w-6 mr-2 text-secondary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                </svg>
                Options de conversion
              </h2>
              <ConversionOptions
                file={file}
                targetFormat={targetFormat}
                onFormatChange={handleFormatChange}
                onConvert={handleConversion}
                isConverting={isConverting}
              />
            </div>
          </div>

          {(convertedFile || error) && (
            <div className="mt-12 card transform transition-all duration-500 animate-fade-in">
              <ConversionResult
                convertedFile={convertedFile}
                error={error}
                fileName={file?.name}
                targetFormat={targetFormat}
              />
            </div>
          )}
        </div>
      </div>
      
      <Features />
      
      <div className="bg-gray-50 dark:bg-gray-900/50 py-12">
        <div className="max-w-4xl mx-auto px-4 text-center">
          <h2 className="text-2xl font-bold mb-4">Prêt à convertir vos fichiers ?</h2>
          <p className="text-gray-600 dark:text-gray-300 mb-8">
            Notre outil est gratuit, rapide et sécurisé. Aucune inscription requise.
          </p>
          <a 
            href="#converter" 
            className="btn btn-primary inline-flex items-center"
          >
            <svg className="h-5 w-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" />
            </svg>
            Commencer la conversion
          </a>
        </div>
      </div>
    </div>
  );
}
