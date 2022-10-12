using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Instanciate512Cubes : MonoBehaviour
{
    public GameObject _sampleCubePrefab;
    public float _maxScale;
    public float cubeBaseSize;
    
    private GameObject[] sampleCube = new GameObject[512];
    // Start is called before the first frame update
    void Start()
    {
        for (int i = 0; i < 512; i++)
        {
            GameObject init = (GameObject)Instantiate(_sampleCubePrefab);
            init.transform.position = this.transform.position;
            init.transform.parent = this.transform;
            init.name = "Cube" + i;
            this.transform.eulerAngles = new Vector3(0, -0.70312f * i, 0);
            init.transform.position = Vector3.forward * 100;
            sampleCube[i] = init;
        }
    }

    // Update is called once per frame
    void Update()
    {
        for (int i = 0; i < 512; i++)
        {
            if (sampleCube[i] != null)
            {
                sampleCube[i].transform.localScale = new Vector3(cubeBaseSize, AudioPeer._samples[i] * _maxScale + 2 , cubeBaseSize);
            }
        } 
    }
}
