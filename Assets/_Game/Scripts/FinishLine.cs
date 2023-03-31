using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FinishLine : MonoBehaviour
{
    public event EventHandler onIsCrossed;

    private void OnTriggerEnter(Collider other)
    {
        Debug.Log("Hit Finish");
        onIsCrossed?.Invoke(this, EventArgs.Empty);
    }

}
