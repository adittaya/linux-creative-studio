import React from 'react';
import { AbsoluteFill, interpolate, spring, useCurrentFrame, useVideoConfig } from 'remotion';

export type SampleProps = {
  title: string;
  subtitle: string;
  accent: string;
};

export const StudioSample: React.FC<SampleProps> = ({title, subtitle, accent}) => {
  const frame = useCurrentFrame();
  const {fps} = useVideoConfig();
  const enter = spring({frame, fps, config: {damping: 200}});
  const opacity = interpolate(frame, [0, 15, 75, 90], [0, 1, 1, 0], {extrapolateRight: 'clamp'});

  return (
    <AbsoluteFill style={{backgroundColor: '#0b1220', color: 'white', fontFamily: 'sans-serif', opacity}}>
      <AbsoluteFill style={{justifyContent: 'center', alignItems: 'center', transform: `translateY(${(1 - enter) * 40}px)`}}>
        <h1 style={{fontSize: 96, margin: 0, color: accent}}>{title}</h1>
        <p style={{fontSize: 36, opacity: 0.8}}>{subtitle}</p>
      </AbsoluteFill>
    </AbsoluteFill>
  );
};
