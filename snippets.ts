// npm i -g @nestjs/cli
// nest new project-name

export function addCommas(n: number | string) {
  return n.toString().replace(/(\d)(?=(\d{3})+($|,|\.))/g, '$1,');
}

export function unindent(text: string) {
  const lines = text.split('\n');
  const spacesToRemove = Math.min(
    ...lines
      .filter((line) => line.trim() !== '')
      .map((line) => {
        let i;
        for (i = 0; i < line.length; i++) {
          if (line[i] !== ' ') {
            return i;
          }
        }
        return i;
      }),
  );
  return lines.map((line) => line.substring(spacesToRemove)).join('\n');
}

export class Settings {
  defaultDatabase: undefined | string;
  readTimeout: undefined | number;

  constructor(partial?: Partial<Settings>) {
    if (partial) {
      Object.assign(this, partial);
    }
  }
}



// throw error without eslint tripping up
if (Math.random() > 10) {
  throw new Error('foo');
}

// return without eslint tripping up
if (Math.random() < 10) {
  return;
}
