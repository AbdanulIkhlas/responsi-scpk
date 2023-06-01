function varargout = nomor2_SAW_123210009(varargin)
% NOMOR2_SAW_123210009 MATLAB code for nomor2_SAW_123210009.fig
%      NOMOR2_SAW_123210009, by itself, creates a new NOMOR2_SAW_123210009 or raises the existing
%      singleton*.
%
%      H = NOMOR2_SAW_123210009 returns the handle to a new NOMOR2_SAW_123210009 or the handle to
%      the existing singleton*.
%
%      NOMOR2_SAW_123210009('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NOMOR2_SAW_123210009.M with the given input arguments.
%
%      NOMOR2_SAW_123210009('Property','Value',...) creates a new NOMOR2_SAW_123210009 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nomor2_SAW_123210009_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nomor2_SAW_123210009_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nomor2_SAW_123210009

% Last Modified by GUIDE v2.5 30-May-2023 14:25:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nomor2_SAW_123210009_OpeningFcn, ...
                   'gui_OutputFcn',  @nomor2_SAW_123210009_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before nomor2_SAW_123210009 is made visible.
function nomor2_SAW_123210009_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nomor2_SAW_123210009 (see VARARGIN)

% Choose default command line output for nomor2_SAW_123210009
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nomor2_SAW_123210009 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nomor2_SAW_123210009_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in tampilButton_009.
function tampilButton_009_Callback(hObject, eventdata, handles)
% hObject    handle to tampilButton_009 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data = readcell('DATA RUMAH.xlsx', 'Range', 'A2:H51');

% memasukkan  data ke dalam tabelData_009
set(handles.tabelData_009,'data',data);


% --- Executes on button press in hasilButton_009.
function hasilButton_009_Callback(hObject, eventdata, handles)
% hObject    handle to hasilButton_009 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% memanggil nilai nama rumah dan kriteria dari file excel
dataRumah = cell2mat(readcell('DATA RUMAH.xlsx', 'Range', 'C2:G51'));
namaRumah = readcell('DATA RUMAH.xlsx', 'Range', 'B2:B51');


[m n] = size(dataRumah); % Mendapatkan ukuran matriks dataRumah
R = zeros(m,n);

%inisialisi kriteria dan weight(bobot)
kriteria = [0,1,1,1,1] ;
weight = [0.30, 0.15, 0.20, 0.20, 0.15] ;

for j=1:n
    if kriteria(j)==1 
        R(:,j) = dataRumah(:,j)./max(dataRumah(:,j));
    else
        R(:,j) = min(dataRumah(:,j))./dataRumah(:,j);
        
    end
end
% Menghitung nilai V untuk setiap baris
V = sum(weight .* R, 2);  


% variabel untuk menyimpan hasil SAW dan index
[hasilSAW, index] = sort(V,'descend');

% variabel untuk menyimpan hasil SAW dalam bentuk cell
hasil = hasilSAW.';

% variabel untuk menyimpan index SAW dalam bentuk matriks
indexHasil = index.';

% Inisialisasi array cell
nama = cell(size(namaRumah));

% Memasukkan nilai ke dalam array cell menggunakan looping
for i = 1:numel(namaRumah)
    nama{i} = namaRumah{i};
end

% membuat cell untuk menampung nama rumah
hasilNamaRumah = cell(4,1); 
[m, n] = size(indexHasil);  % Mendapatkan ukuran matriks indexHasil

% memeriksa setiap elemen matriks index
for i = 1:n
    for j = 1:m
        % memasukkan nama rumah berdasarkan index sesuai dengan indexHasil yang sudah di sorting
        hasilNamaRumah{i} = nama{indexHasil(j,i)};
    end
end

hasil = transpose(hasil); % transpose hasil
hasil = num2cell(hasil);  % Mengubah V menjadi matriks sel

% variabel menyimpan hasil akhir
hasilAkhir = [hasil hasilNamaRumah];
hasilAkhir = hasilAkhir(1:50, :);

rumahIdeal = hasilNamaRumah{1};
nilaiSAW   = hasil{1};

set(handles.idealNama_009, 'string', rumahIdeal);
set(handles.idealSAW_009, 'string', nilaiSAW);

% menampilkan hasil akhir ke tabel hasil
set(handles.tabelHasil_009, 'Data', hasilAkhir);
