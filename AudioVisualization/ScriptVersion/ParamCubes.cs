using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ParamCubes : MonoBehaviour
{
    public int band;

    public float startScale;

    public float scaleMul;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        transform.localScale = new Vector3(transform.localScale.x, (AudioPeer.freqBand[band] * scaleMul) + startScale,
            transform.localScale.z);
    }
}
