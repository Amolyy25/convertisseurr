'use client';

import { createFFmpeg, fetchFile } from '@ffmpeg/ffmpeg';
import { FileWithPreview, SupportedFormat } from './types';

// Créer une instance FFmpeg
const ffmpeg = createFFmpeg({
  log: true,
  corePath: 'https://unpkg.com/@ffmpeg/core@0.11.0/dist/ffmpeg-core.js',
});

let ffmpegLoaded = false;

// Fonction pour charger FFmpeg
export async function loadFFmpeg() {
  if (!ffmpegLoaded) {
    await ffmpeg.load();
    ffmpegLoaded = true;
  }
  return ffmpeg;
}

// Fonction pour convertir une image
export async function convertImage(
  file: FileWithPreview,
  targetFormat: SupportedFormat
): Promise<string> {
  try {
    const ffmpegInstance = await loadFFmpeg();
    
    const inputFileName = 'input_file';
    const outputFileName = `output_file.${targetFormat}`;
    
    // Écrire le fichier dans le système de fichiers virtuel de FFmpeg
    ffmpegInstance.FS('writeFile', inputFileName, await fetchFile(file));
    
    // Exécuter la commande de conversion
    await ffmpegInstance.run(
      '-i', inputFileName,
      '-f', targetFormat === 'jpg' ? 'mjpeg' : targetFormat,
      outputFileName
    );
    
    // Lire le fichier de sortie
    const data = ffmpegInstance.FS('readFile', outputFileName);
    
    // Créer un blob URL pour le fichier converti
    const blob = new Blob([new Uint8Array(data.buffer)], { type: `image/${targetFormat}` });
    const url = URL.createObjectURL(blob);
    
    // Nettoyer les fichiers
    ffmpegInstance.FS('unlink', inputFileName);
    ffmpegInstance.FS('unlink', outputFileName);
    
    return url;
  } catch (error) {
    console.error('Erreur lors de la conversion de l\'image:', error);
    throw new Error('La conversion de l\'image a échoué');
  }
}

// Fonction pour convertir une vidéo
export async function convertVideo(
  file: FileWithPreview,
  targetFormat: SupportedFormat
): Promise<string> {
  try {
    const ffmpegInstance = await loadFFmpeg();
    
    const inputFileName = 'input_file';
    const outputFileName = `output_file.${targetFormat}`;
    
    // Écrire le fichier dans le système de fichiers virtuel de FFmpeg
    ffmpegInstance.FS('writeFile', inputFileName, await fetchFile(file));
    
    // Exécuter la commande de conversion
    await ffmpegInstance.run(
      '-i', inputFileName,
      '-c:v', targetFormat === 'mp4' ? 'libx264' : 'copy',
      outputFileName
    );
    
    // Lire le fichier de sortie
    const data = ffmpegInstance.FS('readFile', outputFileName);
    
    // Créer un blob URL pour le fichier converti
    const blob = new Blob([new Uint8Array(data.buffer)], { type: `video/${targetFormat}` });
    const url = URL.createObjectURL(blob);
    
    // Nettoyer les fichiers
    ffmpegInstance.FS('unlink', inputFileName);
    ffmpegInstance.FS('unlink', outputFileName);
    
    return url;
  } catch (error) {
    console.error('Erreur lors de la conversion de la vidéo:', error);
    throw new Error('La conversion de la vidéo a échoué');
  }
}

// Fonction principale de conversion
export async function convertFile(
  file: FileWithPreview,
  targetFormat: SupportedFormat
): Promise<string> {
  if (file.type.startsWith('image/')) {
    return convertImage(file, targetFormat as SupportedFormat);
  } else if (file.type.startsWith('video/')) {
    return convertVideo(file, targetFormat as SupportedFormat);
  } else {
    throw new Error('Type de fichier non pris en charge');
  }
} 