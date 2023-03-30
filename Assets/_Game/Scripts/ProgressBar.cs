using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ProgressBar : MonoBehaviour
{
    [SerializeField] private Image fillImg;
    public event EventHandler onFinished;

    private void Awake()
    {
        fillImg.fillAmount = 0;
    }

    public void FillUp(float loadDuration)
    {
        StartCoroutine(COR_FillUp());

        IEnumerator COR_FillUp()
        {
            float t = 0;
            while (t < 1)
            {
                t += Time.deltaTime / loadDuration;
                fillImg.fillAmount = t;
                yield return null;
            }
            onFinished?.Invoke(this, EventArgs.Empty);
        }
    }
}
