# Exercise 12 — FIR Low-Pass Filter (sinc) in MATLAB/Octave

## What I did
I implemented an ideal low-pass FIR using the truncated sinc formula:

\[
h_{LP}(n) = \frac{\sin\!\big(\omega_c (n - M/2)\big)}{\pi (n - M/2)}, \quad
h_{LP}[M/2] = \omega_c/\pi,
\]
for \( n = 0,\ldots,M \). I computed the frequency response with a 1024-point FFT and compared two filter orders: **M = 20** and **M = 64**.

## Figures
See the `figures/` folder

## Key observations (what I learned)
1. **Higher order (larger M) narrows the transition band** around the cutoff: the main-lobe in the spectrum gets thinner, so the passband/stopband separation is sharper.  
2. **Impulse response length equals M+1**, so increasing M makes the sinc window longer and more symmetric around \( n = M/2 \).  
3. With the same rectangular truncation, **sidelobe levels stay roughly the same amplitude**, but there are more of them and located closer to the cutoff as M grows; the key benefit is the **reduced main-lobe width**, giving a cleaner edge.  
4. Practically, **M=64** yields a noticeably **sharper and smoother magnitude response** than **M=20**, with less leakage into the stopband around the cutoff and a flatter passband near DC.  
5. The choice of **M trades off** between frequency selectivity (larger M) and computational cost/latency (longer impulse response).
