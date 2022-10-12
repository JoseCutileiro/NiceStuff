using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent( (typeof(AudioSource)))]
public class AudioPeer : MonoBehaviour
{
    private AudioSource _audioSource;

    public static float[] _samples = new float[512];

    public static float[] freqBand = new float[8];
    // Start is called before the first frame update
    void Start()
    {
        _audioSource = GetComponent<AudioSource>();
    }

    // Update is called once per frame
    void Update()
    {
        GetSpectrumAudioSource();
        MakeFreqBands();
    }

    void GetSpectrumAudioSource()
    {
        // FFTWINDOW => Blackman Hamming
        // Get the spectrum :) 
        _audioSource.GetSpectrumData(_samples, 0, FFTWindow.Blackman);
    }

    void MakeFreqBands()
    {
        /* Hertz da musica / 512 <Bands = 43 hz per sample */
        
        /*
         * 20 a 60 hz
         * 60 a 250 hz
         * 250 a 500 hz
         * 500 a 2000 hz
         * 2000 a 4000 hz
         * 4000 a 6000 hz
         * 6000 a 20000 hz
         */

        int count = 0;

        for (int i = 0; i < 8; i++)
        {
            int sampleCount = (int)Mathf.Pow(2, i) * 2;
            float avg = 0;
            if (i == 7)
            {
                sampleCount += 2;
            }

            for (int j = 0; j < sampleCount; j++)
            {
                avg += _samples[count] * count+1;
                count++;
            }

            avg /= count;

            freqBand[i] = avg * 10;

        }

    }

}
