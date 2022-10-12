using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent( (typeof(AudioSource)))]
public class AudioPeer : MonoBehaviour
{
    private AudioSource _audioSource;

    public float[] _samples = new float[512];
    // Start is called before the first frame update
    void Start()
    {
        _audioSource = GetComponent<AudioSource>();
    }

    // Update is called once per frame
    void Update()
    {
        GetSpectrumAudioSource();
    }

    void GetSpectrumAudioSource()
    {
        // FFTWINDOW => Blackman Hamming
        // Get the spectrum :) 
        _audioSource.GetSpectrumData(_samples, 0, FFTWindow.Blackman);
    }
}
